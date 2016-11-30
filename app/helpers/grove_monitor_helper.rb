module GroveMonitorHelper

  def showing_location?
    @display_type == :location
  end

  def showing_status?
    @display_type == :status
  end

  def category_header
    case @display_type
      when :location then category_tag( @location.name.titleize)
      when :status then category_tag("#{@category.titleize} Students")
      else category_tag('Students')
    end
  end

  protected

  def category_tag(text)
    content_tag(:h2, text)
  end
end
