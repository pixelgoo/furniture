module ApplicationHelper

  def bootstrap_class_for(flash_type)
    bootstrap_flash_msg = {
      success: 'alert-success',
      error: 'alert-error',
      alert: 'alert-block',
      notice: 'alert-info'
    }
    bootstrap_flash_msg[flash_type.to_sym] || 'alert-info'
  end

  def current?(name)
    "current" if controller_name == name || current_page?(name)
  end

  def hide_header?
    controller.class.name == 'ProfilesController' ||
    controller.class.name == 'RequestsController' ||
    controller.class.name == 'Users::RegistrationsController' ||
    controller.class.name == 'Users::SessionsController'
  end

  def hide_footer?
    controller.class.name == 'Users::RegistrationsController' ||
    controller.class.name == 'Users::SessionsController'
  end

  def content_aside?
    controller.class.name == 'ProfilesController' ||
    controller.class.name == 'RequestsController'
  end

end
