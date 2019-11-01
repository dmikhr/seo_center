FactoryBot.define do
  factory :page do
    sequence :path do |n|
      "page_#{n}"
    end
    website
  end
end
