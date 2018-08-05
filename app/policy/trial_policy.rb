class TrialPolicy < Policy

  def self.trial_access(user)
    user.created_at >= Time.now - user.trial.days
  end
  
end