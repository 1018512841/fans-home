# -*- encoding : utf-8 -*-
module StaticPageHelper
  def generate_navbar_item(url, text)
    content_tag 'li', role: 'presentation' do
      link_to text, url, role: 'menuitem', tabindex: '-1'
    end
  end

  def generate_tooltip_link(url, tooltip_text, class_name)
    link_to '', url, class: class_name, rel: 'tooltip', data: {placement: 'top', original_title: tooltip_text}
  end

  def banner_data
    [asset_path('backgrounds/1.jpg'),
     asset_path('backgrounds/2.jpg'),
     asset_path('backgrounds/3.jpg')].to_json
  end
end
