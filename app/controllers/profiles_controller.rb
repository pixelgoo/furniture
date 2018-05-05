class ProfilesController < ApplicationController
    before_action :authenticate_user!

    def show
    end

    def settings
        @tariffs = Tariff.all
    end

    def account
    end

    def update_status
        if  Tariff::STATUSES.include? params[:status]
            
            case params[:status]
            when 'inactive'
                current_user.set_tariff_status(:inactive)
                flash[:notice] = I18n.t('tariff.status_changed_to_inactive')
            when 'active'
                current_user.set_tariff_status(:active)
                if current_user.enough_money?
                    flash[:notice] = I18n.t('tariff.status_changed_to_active')
                else
                    flash[:warning] = I18n.t('tariff.status_changed_to_inactive_no_money')
                end
            end

            redirect_to account_path
        else 
            logger.warn "[profiles#update] wrong status parameter received!"
            redirect_to root_path
        end
    end
end
