User.create!(name: 'kanrisya', email: 'kanri@sya.com', password: 'foobar', password_confirmation: 'foobar',
   admin: true, dob: '1992-05-03', sex: 'male')
User.create!(name: '患者A', email: 'kanja@ex.com', password: 'foobar', password_confirmation: 'foobar', dob: '1992-05-03', sex:'male')

50.times do |n|
  date = Faker::Date.between(from: '2021-01-01', to: '2021-08-01')
  bt = rand(35.8..37.2).ceil(1)
  hr = rand(50..70)
  sbp = rand(90..140)
  dbp = rand(50..80)
  wt = rand(49.0..50.1).ceil(1)
  Checklist.create!(date: date, bt: bt, hr: hr, sbp: sbp, dbp: dbp, wt: wt, user_id: 2)
end