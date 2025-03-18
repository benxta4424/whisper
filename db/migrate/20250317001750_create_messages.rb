class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.references :chat_room, null: false, foreign_key: { on_table: :chat_rooms }
      t.text :content

      t.timestamps
    end
  end
end
