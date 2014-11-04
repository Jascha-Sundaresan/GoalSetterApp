class AddCompletionToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :complete, :boolean, default: false
  end
end
