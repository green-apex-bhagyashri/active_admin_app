FactoryBot.define do
    factory :article do
      association :author
      title { "create first blog" }
      description { "password" }
      published_at {Time.current + 5.minutes}
      author_id { author.id }
    end
end 