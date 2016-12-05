class StudentPolicy < AdminResourcePolicy

  def rebuild_schedule?
    user.admin?
  end

end
