class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_s3_direct_post, only: [:settings]

    def show
    end

    def settings
        @tariffs = Tariff.all
    end

    private

    def set_s3_direct_post
        @s3_direct_post = S3_BUCKET.presigned_post(key: "documents/#{current_user.id}/${filename}", success_action_status: '201')
    end
end
