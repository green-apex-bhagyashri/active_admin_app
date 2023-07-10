FactoryBot.define do
    factory :admin_user do
      email { "john@email_provider.com" }
      password { "password" }
    end
  end 