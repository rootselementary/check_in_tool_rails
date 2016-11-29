module CompassHelper

  # @param panel [Panel] Panel object defined in EventPresenter
  def panel(panel)
    image = panel.image
    title = panel.content
    inner_html = ''
    if image.empty?
      inner_html << title_h3(title)
    else
      inner_html << image_tag(image, class: 'img-responsive center-block')
      inner_html << title_h3(title)
    end
    content_tag(:div, inner_html.html_safe, class: 'col-md-4 compass-image')
  end

  # @param [EventPresenter] event
  def scan_in_link(event)
    url = "scan://scan?callback=#{checkin_url}?event_id=#{event.id}"
    link_to(fa_icon("qrcode", text: "Scan"), url, class: "btn btn-success")
  end

  def title_h3(title)
    content_tag(:h3, title)
  end
end
