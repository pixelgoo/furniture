class TariffPolicy < Policy

  def self.tariff_access(user)
    user.tariff_active?
  endz

end