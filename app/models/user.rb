class User
  include MongoMapper::Document
  key :user_name, String
  key :user_email, String
  key :salt, String
  key :encrypted_password, String
  key :role, String
  timestamps!

  attr_accessor :password
  attr_reader :password_confirmation

  validates :user_name, :presence => true, :uniqueness => true
  validates :user_email, :presence => true, :uniqueness => true,
            :format => {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create}
  validates :password, :confirmation => true, :presence => true

  def password=(password)
    @password = password
    if @password.present?
      generate_salt
      @encrypted_password = self.class.encrypt_password(self.password, self.salt)
    end
  end

  def self.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "fans-home" + salt)
  end

  def self.get_user_list
    users_array = self.all.map do |each|
      [
          "<a href='/users/#{each._id}' user_id='#{each._id}'  class='user_link'>#{each.user_name}</a>",
          each.user_email
      ]
    end

    return users_array
  end

  def self.destroy_user_by_ids(user_ids)
    message = []
    status = "success"
    user_ids.each do |user_id|
      user = self.find(user_id)
      unless current_user?(user)
        status = "error"
        message.push("'#{user_id}' "+I18n.t("delete_self_error"))
        break
      end

      if user.present?
        user.destroy
        if user
          status = "success"
          message.push(I18n.t("delete_user_list_success")+ ", name=#{user.user_name}")
        else
          status = "error"
          message.push(I18n.t("delete_user_list_failed")+ ", name=#{user.user_name}")
        end
      else
        status = "error"
        message.push("'#{user_id}' "+I18n.t("delete_user_list_not_existing"))
      end
    end
    return status, message
  end

  def authenticate_password(password)
    self.encrypted_password == self.class.encrypt_password(password, self.salt)
  end

  def self.check_user_login(user, password)
    message = {:inputPassword => [],
               :inputEmail => []}
    if user.nil?
      status = 'failed'
      message[:inputEmail].push("User email invalid")
    elsif user.authenticate_password(password)
      status = 'success'
    else
      status = 'failed'
      message[:inputPassword].push("Password invalid")
    end
    result = {:status => status, :message => message}
    return result
  end

  private

  def generate_salt
    self.salt= self.object_id.to_s + rand.to_s
  end
end
