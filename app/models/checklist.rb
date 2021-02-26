class Checklist < ApplicationRecord
  with_options presence: true do
    validates :date, uniqueness: true
    validates :bt
    validates :hr
    validates :sbp
    validates :dbp
  end
end
