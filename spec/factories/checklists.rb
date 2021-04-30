FactoryBot.define do
  factory :checklist do
    date { '2021-04-23' }
    bt { 36.5 }
    hr { 60 }
    sbp { 130 }
    dbp { 70 }
    wt { 60.2 }
    memo { '休日でした' }
    user
  end
end
