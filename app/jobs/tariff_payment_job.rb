class TariffPaymentJob < ApplicationJob
  queue_as :default

  after_perform do |job|
    self.class.set(:wait => 1.day).perform_later(job.arguments.first) if job.arguments.first.tariff_active?
  end

  def perform(user)
    user.perform_tariff_payment
  end
end
