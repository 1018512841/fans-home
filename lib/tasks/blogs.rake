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

    cnblog = CnblogConvert.new(user_id: 'fanxiaopeng',
                               user_name: 'besfan',
                               password: '123zxc123')
    cnblog.convert do |title, created_at, body|
      Blog.create({
                      title: title,
                      created_at: created_at,
                      body: body,
                      mime: 'html',
                      origin: 'cnblog',
                      user: user
                  })
    end

  end
  task :csdn => :environment do
    unless user = User.where(user_name: 'csdn').last
      user = User.create(
          user_name: 'csdn',
          user_email: 'csdn@qq.com',
          password: '123456',
          password_confirmation: '123456',
          role: 'admin'
      )
    end
    csdn = CsdnConvert.new(user, user_id: 'besfanfei')
    csdn.convert do |title, created_at, body|
      Blog.create({
                      title: title,
                      created_at: created_at,
                      body: body,
                      mime: 'html',
                      origin: 'csdn',
                      user: user
                  })
    end
  end
end