class AddAgeToUsers < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :age, :integer
  end

  def down
    remove_column :users, :type, :string
  end
end
