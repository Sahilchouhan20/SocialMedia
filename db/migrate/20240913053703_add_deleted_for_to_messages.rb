class AddDeletedForToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :deleted_for, :text, default: '[]'
  end
end
