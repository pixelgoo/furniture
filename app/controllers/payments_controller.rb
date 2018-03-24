
class PaymentsController < ApplicationController
    before_action :authenticate_user!

    def subscribe
        if Tariff.all.map(&:name).exclude? params[:tariff] then
            redirect_to root_path
            return
        end

        if current_user.tariff.nil? then
            @payment = Payment.new
            @payment.user = current_user
            @payment.action = 'subscribe'
            current_user.set_tariff params[:tariff]
            @payment.amount = ActionController::Base.helpers.humanized_money(current_user.tariff.price).delete(' ')
          
            @payment.save

            liqpay = Liqpay.new
            payment_params = {
                action:         @payment.action,
                version:        '3',
                email:          current_user.email,
                amount:         @payment.amount,
                currency:       'UAH',
                description:    I18n.t('payment.subscribe_description') + I18n.t("tariff." + current_user.tariff.name),
                order_id:       @payment.id.to_s,
                subscribe:      '1',
                subscribe_date_start:  Time.now.to_s[0...-6],
                subscribe_periodicity: 'month'
            }
    
            @liqpay_button = liqpay.cnb_form(payment_params)
        else
            redirect_to profile_path
            return
        end
    end
end
