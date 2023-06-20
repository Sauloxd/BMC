module ApplicationHelper
  def avatar_url(avatar)
    avatar.present? ? url_for(avatar) : "https://ui-avatars.com/api/?background=0D8ABC&color=fff&name=AA"
  end

  def sidebar_active?(paths)
    return false if paths.nil?
    
    paths.any? { |p| request.url.match?(p) }
  end
end