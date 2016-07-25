class GroveMonitorPolicy < ApplicationPolicy
  def index?
    user.present? && user.is_a?(Teacher)
  end
  
  def show?
    user.present? && user.is_a?(Teacher)
  end
end
