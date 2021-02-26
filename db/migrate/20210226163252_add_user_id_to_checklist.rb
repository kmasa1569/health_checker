class AddUserIdToChecklist < ActiveRecord::Migration[6.1]
  def up
    execute 'DELETE FROM checklists;'
    add_reference :checklists, :user, null: false, index: true
  end

  def down
    remove_reference :checklists, :user, index: true
  end
end
