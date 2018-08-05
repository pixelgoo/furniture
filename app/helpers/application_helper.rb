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

  def days_left(days)
    if(days == 1 || days == 21)
      days_text = I18n.t('time.days_1')
    elsif([2, 3, 4].include? days)
      days_text = I18n.t('time.days_2')
    else
      days_text = I18n.t('time.days_3')
    end
    "#{days} #{days_text}"
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
