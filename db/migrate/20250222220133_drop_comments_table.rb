class DropCommentsTable < ActiveRecord::Migration[8.0]
  def up
    remove_foreign_key :comments, :users if foreign_key_exists?(:comments, :users)
    drop_table :comments
  end

  def down
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.string :commentable_type, null: false
      t.bigint :commentable_id, null: false
      t.string :content
      t.timestamps
    end
  end
end
