class PaymentsController < ApplicationController
    before_action :authenticate_user!, except: :callback

    def subscribe
        if Tariff.all.map(&:name).exclude? params[:tariff] then
            redirect_to root_path
            return
        end

        if current_user.tariff.nil? then
            @payment = Payment.new
            @payment.user = current_user
            @payment.action = 'pay'
            @payment.tariff = params[:tariff]
            tariff = Tariff.find_by(name: @payment.tariff)
            @payment.amount = ActionController::Base.helpers.humanized_money(tariff.price).delete(' ')
            @payment.order_id = Payment.generate_order_id
            @payment.save

            liqpay = Liqpay.new
            payment_params = {
                sandbox: '1',
                action:         @payment.action,
                version:        '3',
                email:          current_user.email,
                amount:         @payment.amount,
                currency:       'UAH',
                description:    I18n.t('payment.subscribe_description') + I18n.t("tariff." + tariff.name),
                order_id:       @payment.order_id,
                result_url:     Rails.configuration.exposed_host + callback_path
            }
    
            @liqpay_button = liqpay.cnb_form(payment_params)
        else
            redirect_to profile_path
            return
        end
    end

    def callback
        if liqpay.match?(params[:data], params[:signature]) then
            responce_hash = liqpay.decode_data(data)
            logger.debug responce_hash

            payment = Payment.find_by(order_id: responce_hash['order_id'])
            payment.status = responce_hash['status']
            payment.save

            case responce_hash['status']
            when 'success'
            when 'sandbox'
                current_user.set_tariff payment.tariff
            when 'failure'

            end

            @status = payment.status
            logger.debug current_user
        else
            logger.warn "Liqpay: wrong signature received!"
            redirect_to root_path
        end
    end
end
