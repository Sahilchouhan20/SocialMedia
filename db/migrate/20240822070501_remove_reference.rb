class RemoveReference < ActiveRecord::Migration[7.1]
  def change
    remove_reference :stories, :post, foreign_key: true, index: false
  end
end
