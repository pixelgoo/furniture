

module ImageHelper
  def cdn_image_tag(path)
    raw "<img src='https://d3lbdc0bfetw94.cloudfront.net/#{path}'>"
  end
end
