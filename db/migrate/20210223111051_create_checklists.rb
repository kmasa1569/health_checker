class CreateChecklists < ActiveRecord::Migration[6.1]
  def change
    create_table :checklists do |t|
      t.date :date
      t.float :bt
      t.integer :hr
      t.integer :sbp
      t.integer :dbp
      t.float :wt

      t.timestamps
    end
  end
end
