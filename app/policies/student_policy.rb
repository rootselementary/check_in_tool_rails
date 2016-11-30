class StudentPolicy < AdminResourcePolicy

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        user.grove.students
      end
    end
  end

  def rebuild_schedule?
    user.admin?
  end

end
