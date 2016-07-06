class CompassPolicy < ApplicationPolicy
  def show?
    user.present? && user.is_a?(Student)
  end
end
