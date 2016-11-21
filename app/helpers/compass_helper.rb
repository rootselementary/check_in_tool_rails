module CompassHelper

  def panel(image, title)
    inner_html = ''
    if image.nil?
      inner_html << title_h3(title)
    else
      inner_html << image_tag(image, class: 'img-responsive center-block')
      inner_html << title_h3(title)
    end
    content_tag(:div, inner_html.html_safe, class: 'col-md-4 compass-image')
  end

  def title_h3(title)
    content_tag(:h3, title)
  end
end
