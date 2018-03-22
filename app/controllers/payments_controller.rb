
class PaymentsController < ApplicationController

    def new
        if payment_type_permitted?(params[:type]) then
            @payment = Payment.new

            case params[:type]
            when 'request'
                @payment.action = 'pay'
                @payment.request = Request.find(params[:request])
                @payment.amount = ActionController::Base.helpers.humanized_money(payment.request.amount)
            when 'tariff'
                @payment.action = 'subscribe'
                @payment.tariff = Tariff.find(params[:tariff])
                @payment.amount = ActionController::Base.helpers.humanized_money(payment.tariff.price)
            else
            end

        else
            raise ActionController::RoutingError.new('Not Found')        
        end
    end

    def create

        case params[:type]
        when 'request'
            payment.action = 'pay'
            payment.request = Request.find(params[:request])
            if(ActionController::Base.helpers.humanized_money(payment.request.amount) == params[:amount])
                payment.amount = params[:amount]
            else 
                raise InvalidAmountException
            end
        when 'tariff'
            payment.action = 'subscribe'
            payment.tariff = Tariff.find(params[:tariff])
            if(ActionController::Base.helpers.humanized_money(payment.tariff.price) == params[:amount])
                payment.amount = params[:amount]
            else 
                raise InvalidAmountException
            end
        else
            raise WrongPaymentTypeException
        end

        if payment.save
            redirect_to "/payments/pending"
        else
            flash[:notice] = "#{payment}"
            render :template => "payments/new"
        end
        

        liqpay = Liqpay.new
        liqpay.api('request', {
          action:         payment.action,
          version:       '3',
          email:          current_user.email,
          amount:         payment.amount,
          currency:      'UAH',
          order_id:       payment.id
          card:           params[:card],
          card_exp_month: params[:card_exp_month],
          card_exp_year:  params[:card_exp_year],
          card_cvv:       params[:card_cvv],
          receiver_card:  Rails.application.secrets.receiver_card,
          sandbox: "1"
        })
    end
   
    def pending

    end

    # Error handling

    class WrongPaymentTypeException < StandardError
    end

    class InvalidAmountException < StandardError
    end
  
    rescue_from WrongPaymentTypeException, :with => :payment_exception_handler
    rescue_from InvalidAmountException, :with => :payment_exception_handler

    def payment_exception_handler(exception)
      flash[:notice] = I18n.t controllers.payment_exception
      Rails.logger.warn "Something bad happend in the PaymentsController: #{exception}"
      redirect_to "/"
    end

    private

    def payment_type_permitted?
        (params & %w(request tariff)).any?
    end
end
