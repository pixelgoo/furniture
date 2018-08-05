class RequestsPolicy < Policy

  def self.requirements_access(user)
    user.tariff_active? && user.documents_confirmed?
  end

  def self.tariff_access(user, request)
    user.manufacturer? ? request.created_at <= Time.now - user.tariff.request_visibility.hours : true
  end

end