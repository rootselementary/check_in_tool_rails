class TeacherPolicy < ApplicationPolicy
  def index?
    user.present? && user.is_a?(Teacher)
  end

  alias_method :show?, :index?
end
