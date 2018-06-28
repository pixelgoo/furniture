# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  def create
    super do
        resource.furnitures << Furniture.all
        resource.save
    end
  end

  def after_sign_up_path_for(resource)
    root_path
  end

end
