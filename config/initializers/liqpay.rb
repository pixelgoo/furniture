::Liqpay.configure do |config|
    config.public_key = Rails.env.development? ? Rails.application.secrets.public_key : ENV["PUBLIC_KEY"]
    config.private_key = Rails.env.development? ? Rails.application.secrets.private_key : ENV["PRIVATE_KEY"]
end