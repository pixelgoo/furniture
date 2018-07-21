class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_s3_direct_post, only: [:show]

  def show
    if current_user.manufacturer?
      @user_files_uploaded = current_user.files_uploaded == User::MAX_FILES_UPLOADED
      @user_tariff_active = current_user.tariff_active?
      @user_documents_confirmed = current_user.documents_confirmed
      @tariffs = Tariff.all

      furnitures = Furniture.all
      regions = Region.all
      @settings = {
        'regions' => regions,
        'regions_ids' => regions.ids,
        'user_regions_ids' => current_user.region_ids,

        'furnitures' => furnitures,
        'furnitures_ids' => furnitures.ids,
        'user_furnitures_ids' => current_user.furniture_ids
      }
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
    if(User::SETTINGS_AVAILABLE.include?(params[:model].to_sym))
      model = params[:model]
      model_objects = model.capitalize.constantize.all
      user_model_objects = current_user.send("#{model}s")
      user_model_objects_ids = user_model_objects.ids
      objects_to_delete = []
      params[:set_model].delete("set_all_#{model}")
      params[:set_model].each do |index, checked|
        model_object = model_objects[index.scan(/\d+/).first.to_i - 1]
        if checked == '1'
          user_model_objects << model_object unless user_model_objects_ids.include? model_object.id
        else 
          objects_to_delete.push model_object.id
        end
      end
      user_model_objects.delete(*(objects_to_delete & user_model_objects.ids))
      flash[:success] = I18n.t("profile.#{model}s_changed")
    else
      logger.warn "profiles#update_setting: Mismatching model params received"
    end
    redirect_to profile_path
  end

  private

  def set_s3_direct_post
    @s3_direct_post = S3_BUCKET.presigned_post(key: "documents/#{current_user.id}/${filename}", success_action_status: '201') if Rails.env.production?
  end

end
