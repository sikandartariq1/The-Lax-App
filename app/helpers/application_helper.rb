module ApplicationHelper

  def render_profile_picutre(resource, size)
    path = resource.profile_picture_url || '/default_avatar.gif'
    image_tag(path, class: "rounded float-left", size: size)
  end

  def current_entity
    current_user || current_old_salt
  end

end
