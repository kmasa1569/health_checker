class ChangeUserColumns < ActiveRecord::Migration[6.1]
  def change
    def change
      remove_column :users, :age, :integer
      add_column :users, :dob, :date
    end
  end
end
