class LocationPolicy < AdminResourcePolicy

  def show?
    super || (user.teacher? && user.groves.include?(record.grove))
  end

  def destroy?
    false
  end
end
