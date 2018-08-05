class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_s3_direct_post, only: [:show]

  def show
    if current_user.manufacturer?
      @tariffs = Tariff.all
      @settings = UserSettingsService.settings(current_user)
    end
    if current_user.customer?
      @furnitures = Furniture.all
      @requests = current_user.customer_requests
    end
  end

  def upload_documents
    if current_user.files_uploaded + 1 > User::MAX_FILES_UPLOADED
      logger.warn "profiles#upload_documents: Detected file upload excess count"
    else
      current_user.files_uploaded += 1
      current_user.save
    end
  end

  # Updates user habtm associations (regions, furnitures)
  def update_setting
    settings = UserSettingsService.new(params, current_user)
    if settings.validate
      settings.update
      flash[:success] = I18n.t("profile.#{params[:model]}s_changed")
    else  
      logger.warn "profiles#update_setting: Settings update wasn't validated"
    end

    redirect_to profile_path
  end

  private

  def set_s3_direct_post
    @s3_direct_post = S3_BUCKET.presigned_post(key: "documents/#{current_user.id}/${filename}", success_action_status: '201') if Rails.env.production?
  end

end
