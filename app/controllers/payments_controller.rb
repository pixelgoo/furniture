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
            @payment.tariff = params[:tariff]
            @payment.amount = ActionController::Base.helpers.humanized_money(current_user.tariff.price).delete(' ')
          
            @payment.save

            liqpay = Liqpay.new
            payment_params = {
                sandbox: '1',
                action:         @payment.action,
                version:        '3',
                email:          current_user.email,
                amount:         @payment.amount,
                currency:       'UAH',
                description:    I18n.t('payment.subscribe_description') + I18n.t("tariff." + @payment.tariff.name),
                order_id:       Payment.generate_orded_id,
                subscribe:      '1',
                subscribe_date_start:  Time.now.to_s[0...-6],
                subscribe_periodicity: 'month',
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

            case responce_hash['status']
            when 'success'
                current_user.set_tariff payment.tariff
            when 'failure'

            when 'sandbox'

            current_user.set_tariff @payment.tariff

            @status = payment.status
        else
            logger.warn "Liqpay: wrong signature received!"
        end
    end
end
