class LocationPolicy < AdminResourcePolicy

  def index?
    user.teacher? || user.admin?
  end

  def show?
    super || (user.teacher? && user.groves.include?(record.grove))
  end

  def destroy?
    user.admin?
  end
end
