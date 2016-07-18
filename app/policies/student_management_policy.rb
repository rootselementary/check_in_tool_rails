class StudentManagementPolicy < ApplicationPolicy
  def index?
    user.present? && user.is_a?(Teacher)
  end

  alias_method :show?, :index?
  alias_method :create?, :index?
end
