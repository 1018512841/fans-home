class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_name, type: String
  field :user_email, type: String
  field :salt, type: String
  field :encrypted_password, type: String
  field :role, type: String

  attr_accessor :password
  attr_reader :password_confirmation

  validates_presence_of :user_name, :user_email
  validates_uniqueness_of :user_email
  validates_format_of :user_email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_confirmation_of :password

  has_many :blogs

  def password=(password)
    @password = password
    if @password.present?
      generate_salt
      self.encrypted_password = self.class.encrypt_password(self.password, self.salt)
    end
  end

  def authenticate_password(password)
    self.encrypted_password == self.class.encrypt_password(password, self.salt)
  end

  class << self
    def encrypt_password(password, salt)
      Digest::SHA2.hexdigest(password + "fans-home" + salt)
    end

    def destroy_user_by_ids(user_ids, current_user_id)
      message = []
      status = "success"
      user_ids.each do |user_id|
        user = self.find(user_id)
        if current_user_id == user.id.to_s
          status = "error"
          message.push("'#{user.user_name}' "+"不能删除自己")
          break
        end

        if user.present?
          user.destroy
          if user
            status = "success"
            message.push("删除成功"+ ", name=#{user.user_name}")
          else
            status = "error"
            message.push("删除失败"+ ", name=#{user.user_name}")
          end
        else
          status = "error"
          message.push("'#{user_id}' "+"不存在!")
        end
      end
      [status, message]
    end

    def check_user_login(user, password)
      message = {:inputPassword => [],
                 :inputEmail => []}
      if user.nil?
        status = 'failed'
        message[:inputEmail].push("邮箱不正确")
      elsif user.authenticate_password(password)
        status = 'success'
      else
        status = 'failed'
        message[:inputPassword].push("密码错误")
      end
      {:status => status, :message => message}
    end
  end

  private

  def generate_salt
    self.salt= self.object_id.to_s + rand.to_s
  end
end
