FactoryBot.define do
  factory :link do
    page { nil }
    anchor { "MyString" }
    url { "MyString" }
    internal { false }
  end
end
