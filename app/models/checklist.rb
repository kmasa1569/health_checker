class Checklist < ApplicationRecord
  def self.csv_attributes
    ['date', 'bt', 'hr', 'sbp', 'dbp', 'wt']
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |checklist|
        csv << csv_attributes.map{ |attr| checklist.send(attr) }
      end
    end
  end

  with_options presence: true do
    validates :date, uniqueness: true
    validates :bt
    validates :hr
    validates :sbp
    validates :dbp
  end

  belongs_to :user
end
