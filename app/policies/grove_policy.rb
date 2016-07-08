class GrovePolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  alias_method :new?, :index?
  alias_method :create?, :index?
  alias_method :update?, :index?
  alias_method :edit?, :index?


  def destroy?
    show?
  end
end
