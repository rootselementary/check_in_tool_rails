class GrovePolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def new?
    index?
  end

  def create?
    index?
  end
end
