module ApplicationHelper

  def bootstrap_class_for(flash_type)
    bootstrap_flash_msg = {
      success: 'alert-success',
      alert: 'alert-danger',
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
    controller.class.name == 'Users::SessionsController' ||
    controller.class.name == 'Users::PasswordsController'
  end

  def hide_footer?
    controller.class.name == 'Users::RegistrationsController' ||
    controller.class.name == 'Users::SessionsController' ||
    controller.class.name == 'Users::PasswordsController'
  end

  def content_aside?
    controller.class.name == 'ProfilesController' ||
    controller.class.name == 'RequestsController'
  end

end
