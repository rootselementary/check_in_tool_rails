class AddActivityToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :activity, index: true, foreign_key: true
  end

end
