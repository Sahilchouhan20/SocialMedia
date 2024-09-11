class CreateMessagesUsersDeletedFor < ActiveRecord::Migration[7.1]
  def change
    create_table :messages_users_deleted_for, id: false do |t|
      t.bigint :message_id, null: false
      t.bigint :user_id, null: false
    end

    add_index :messages_users_deleted_for, [:message_id, :user_id], unique: true

    add_foreign_key :messages_users_deleted_for, :messages, column: :message_id
    add_foreign_key :messages_users_deleted_for, :users, column: :user_id
  end
end
