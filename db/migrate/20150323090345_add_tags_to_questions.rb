class AddTagsToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :tags, :string
    add_column :questions, :like, :integer
  end
end
