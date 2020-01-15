FactoryBot.define do

  factory :user, class: User do
    sequence(:email) { |i| "email#{i}@admin.com" }
    password { '123123' }
    password_confirmation { '123123' }
  end

  factory :admin, parent: :user do
    e_admin { true }
  end
end
