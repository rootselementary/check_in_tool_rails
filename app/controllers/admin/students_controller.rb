module Admin
  class StudentsController < ResourceController
    protected

    def collection_attributes
      [:name]
    end

    def whitelist
      collection_attributes + [:grove_id]
    end

    def collection
      Student.where(grove: current_user.grove)
             .where('name ILIKE ?', "%#{params[:student_search]}%")
             .order(name: :asc)
             .paginate(page: params[:page], per_page: 25)
    end
  end
end
