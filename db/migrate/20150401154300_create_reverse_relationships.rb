class CreateReverseRelationships < ActiveRecord::Migration
  def change
    create_table :reverse_relationships do |t|
      t.integer :followed_id
      t.integer :follower_id

      t.timestamps
    end
    add_index :reverse_relationships, :follower_id
	add_index :reverse_relationships, :followed_id
  end
end
