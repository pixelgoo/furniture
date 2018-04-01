::Liqpay.configure do |config|
    config.public_key = Rails.application.secrets.public_key
    config.private_key = Rails.application.secrets.private_key
end