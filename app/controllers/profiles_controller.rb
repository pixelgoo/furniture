class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_s3_direct_post, only: [:settings]

  def show
  end

  def settings
    @tariffs = Tariff.all
    @regions = Region.all
  end

  def upload_documents
  end

  def update_regions
    regions = Region.all
    params[:set_region].each do |index, checked|
      user_regions = current_user.regions
      region = regions[index.to_i - 1]
      if checked == '1'
        user_regions << region unless user_regions.include? region
      else 
        user_regions.delete region if user_regions.include? region
      end
    end
  end

  private

  def set_s3_direct_post
    @s3_direct_post = S3_BUCKET.presigned_post(key: "documents/#{current_user.id}/${filename}", success_action_status: '201') if Rails.env.production?
  end

end
