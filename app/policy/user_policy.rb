class UserPolicy < Policy

  def self.confirmed_access(user)
    user.documents_confirmed
  end

  def self.documents_uploaded_access(user)
    user.files_uploaded == User::MAX_FILES_UPLOADED
  end

end