class LocationPolicy < AdminResourcePolicy

  def show?
    super || (user.teacher? && user.groves.include?(record.grove))
  end

  def destroy?
    user.admin?
  end
end
