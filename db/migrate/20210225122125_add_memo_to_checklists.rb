class AddMemoToChecklists < ActiveRecord::Migration[6.1]
  def change
    add_column :checklists, :memo, :text
  end
end
