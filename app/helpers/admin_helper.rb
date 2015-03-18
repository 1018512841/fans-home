module AdminHelper

  def detail_title_tag(desc, small=nil)
    content_tag :div, class: 'panel panel-header' do
      content_tag :h1, class: 'detail-title' do
        concat desc
        concat(content_tag :small, small) if small.present?
      end
    end
  end

  def detail_panel_tag(title, desc)
    content_tag :div, class: 'panel panel-info' do
      concat (content_tag :div, class: 'panel-heading' do
               content_tag :h3, title, class: 'panel-title'
             end)
      concat content_tag :div, desc, class: 'panel-body'
    end
  end

  def right_operation_tag(title="操作:", &option)
    content_tag :div, class: 'col-sm-3 show-sidebar' do
      concat(content_tag :h1, title)
      concat(capture &option)
    end
  end

end
