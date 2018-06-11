class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_s3_direct_post, only: [:settings]

  def show
    if current_user.manufacturer?
      @user_files_uploaded = current_user.files_uploaded == User::MAX_FILES_UPLOADED
      @user_tariff_active = current_user.tariff_active?
      @user_documents_confirmed = current_user.documents_confirmed
      @tariffs = Tariff.all
      @regions_ids = Region.all.collect { |region| region.id }
      @user_regions_ids = current_user.regions.collect { |region| region.id }
    end
    @regions = Region.all
  end

  def upload_documents
    if current_user.files_uploaded + 1 > User::MAX_FILES_UPLOADED
      logger.warn "File uploading: detected file upload excess count"
    else
      current_user.files_uploaded += 1
      current_user.save
    end
  end

  def update_regions
    regions = Region.all
    user_regions = current_user.regions
    params[:set_region].each do |index, checked|
      region = regions[index.to_i - 1]
      if checked == '1'
        user_regions << region unless user_regions.include? region
      else 
        user_regions.delete region if user_regions.include? region
      end
    end
    flash[:success] = I18n.t('profile.regions_changed')
    redirect_to profile_path
  end

  private

  def set_s3_direct_post
    @s3_direct_post = S3_BUCKET.presigned_post(key: "documents/#{current_user.id}/${filename}", success_action_status: '201') if Rails.env.production?
  end

end
