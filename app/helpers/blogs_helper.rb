module BlogsHelper

  def previous_tag(blog)

    if blog.previous_one
      link_to '上一篇', blog_path(blog.previous_one)
    else
      link_to '上一篇', 'javascript:;', class: 'btn btn-default disabled'
    end
  end

  def next_tag(blog)
    if blog.next_one
      link_to '下一篇', blog_path(blog.next_one)
    else
      link_to '下一篇', 'javascript:;', class: 'btn btn-default disabled'
    end
  end

end
