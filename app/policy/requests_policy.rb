class RequestsPolicy < Policy

  def self.requirements_access(current_user)
    user.tariff_active? && user.documents_confirmed?
  end

  def self.tariff_access(user, request)
    request.created_at <= (Time.now - user.tariff.request_visibility.hours)
  end

end