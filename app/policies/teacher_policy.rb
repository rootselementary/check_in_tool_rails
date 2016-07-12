class TeacherPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def destroy?
    index?
  end

  def new?
    index?
  end

  def create?
    index?
  end

  def update?
    index?
  end

  # TODO: this seems wrong
  def show?
    user.present? && user.is_a?(Teacher)
  end
end
