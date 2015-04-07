class CsdnConvert

  def initialize(user, options)
    options = options.with_indifferent_access
    @user = user
    @user_id = options[:user_id]
    @end_point = "http://blog.csdn.net/#{@user_id}"
    @detail_links = []
  end

  def convert(&block)
    init_client
    collect_next_page
    @detail_links.each do |detail|
      post = @agent.get("http://blog.csdn.net#{detail}")
      convert_one(post, &block)
    end
  end

  private

  def init_client
    @agent = Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari'
    }
  end

  def collect_next_page
    current_page = @agent.get(@end_point)
    while current_page
      collect_page_detail(current_page)
      next_page = current_page.link_with(:text => '下一页')
      if next_page
        current_page = @agent.click(next_page)
      else
        current_page = nil
      end
    end
  end

  def collect_page_detail(page_obj)
    page_obj.search('.link_title a').each do |link|
      @detail_links += link.values
    end
  end

  def convert_one(detail, &block)
    title = detail.at('.link_title').text.lstrip.rstrip
    created_at = detail.at('.link_postdate').text.to_time
    body = detail.at('.article_content').inner_html
    block.call(title, created_at, body)
  end

end