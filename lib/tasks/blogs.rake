namespace :blogs do
  task :cnblog => :environment do
    unless user = User.where(user_name: 'cnblog').last
      user = User.create(
          user_name: 'cnblog',
          user_email: 'cnblog@qq.com',
          password: '123456',
          password_confirmation: '123456',
          role: 'admin'
      )
    end

    cnblog = CnblogConvert.new(user, user_id: 'fanxiaopeng',
                               user_name: 'besfan',
                               password: '123zxc123')
    cnblog.convert
  end
  task :csdn do
    # Stub out for MongoDB
  end
end