class AddSexToUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :profession, :string
    add_column :users, :sex, :integer
    add_column :users, :profession, :integer
  end
end
