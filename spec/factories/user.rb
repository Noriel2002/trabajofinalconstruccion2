FactoryBot.define do
    factory :user do
      username { "usuario#{rand(1000)}" }
      email { "usuario#{rand(1000)}@example.com" }
      password { "password123" }
      password_confirmation { "password123" }
    end
  end
  