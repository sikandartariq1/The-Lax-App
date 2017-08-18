module ApplicationHelper

  def render_profile_picutre(resource, size)
    path = resource.profile_picture_url || '/default_avatar.gif'
    image_tag(path, class: "rounded float-left", size: size)
  end

  def render_profile_picutre_with_class(resource, size, classes)
    path = resource.profile_picture_url || '/default_avatar.gif'
    image_tag(path, size: size, class: classes)
  end

  def current_entity
    current_user || current_old_salt
  end

end
