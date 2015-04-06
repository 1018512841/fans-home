class CsdnConvert

  def initialize(user, options)
    options = options.with_indifferent_access
    @user = user
    @user_id = options[:user_id]
    @end_point = "http://blog.csdn.net/#{@user_id}/rss/list"

  end

  def init_client
    a = Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari'
    }
    rss = a.get(@end_point)
    
  end

  def convert_one(post)
    title = post['title']
    created_at = post['dateCreated'].to_time
    body = ReverseMarkdown.convert post['description']
    params = {
        title: title,
        created_at: created_at,
        body: body,
        origin: 'cnblog',
        user: @user
    }
    Blog.create(params)
  end

  def convert
    init_client
    posts = @client.recent_posts(100)
    raise 'MetaWeblog connect error' unless posts.class.to_s == 'Array'
    posts.each do |post|
      convert_one(post)
    end
  end
end