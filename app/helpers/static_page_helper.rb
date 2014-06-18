module StaticPageHelper
  def generate_navbar_item(url, text)
    html_text = <<EOS
      <li role="presentation"><a role="menuitem" tabindex="-1" href="#{url}">
      #{text}</a></li>
EOS
    return html_text

  end

  def generate_tooltip_link(url, tooltip_text, class_name)
    html_text = <<EOS
    <a href="#{url}" class="#{class_name}" rel="tooltip"
data-placement="top" data-original-title=#{tooltip_text}></a>
EOS
    return html_text
  end
end
