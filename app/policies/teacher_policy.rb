class TeacherPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def update?
    user.admin? && user.grove_id == resource.grove_id
  end

  alias_method :new?, :index?
  alias_method :create?, :index?
  alias_method :update?, :index?
  alias_method :edit?, :index?
  alias_method :destroy?, :index?
  alias_method :show?, :index?

end

