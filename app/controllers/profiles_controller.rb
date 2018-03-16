class ProfilesController < ApplicationController
    before_action :authenticate_user!

    def show
        @user = User.find(current_user.id)
        render template: "users/profile"
    end

    def settings

    end
end
