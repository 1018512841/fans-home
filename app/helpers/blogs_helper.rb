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

  def delete_blog_tag(blog)
    if blog.user == current_user
      content_tag :span, class: 'owner-operate' do
        link_to '删除', blog_path(@blog), method: :delete, data: {confirm: 'Are you sure?'}, class: 'btn btn-warning'
      end
    end
  end

end
