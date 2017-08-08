module ApplicationHelper

  def render_profile_picutre(resource)
    path = resource.profile_picture_url || '/default_avatar.gif'
    image_tag(path)
  end

  def current_entity
    current_user || current_old_salt
  end

end
