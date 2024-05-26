FactoryBot.define do
  factory :blog_post, class: 'BlogPosts' do
    title { "Test Post" }
    content { "This is a test post" }
    association :user
  end
end
