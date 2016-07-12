class StudentManagementPolicy < ApplicationPolicy
  def show?
    user.present? && user.is_a?(Teacher)
  end
end
