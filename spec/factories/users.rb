FactoryBot.define do
  factory :user do
    name { 'TestPatient' }
    email { 'patient@example.com' }
    password { 'foobar' }
    dob { '1992-05-03' }
    sex { '男性' }
  end
end