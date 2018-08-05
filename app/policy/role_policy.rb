class RolePolicy < Policy

  def self.admin_access(user)
    user.admin?
  end

  def self.manufacturer_access(user)
    user.manufacturer?
  end

  def self.customer_access(user)
    user.customer?
  end

end