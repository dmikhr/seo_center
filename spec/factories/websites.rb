FactoryBot.define do
  factory :website do
    url { "http://example.com" }
    www { false }
    https { false }
    scanned_time { DateTime.now }
  end

  trait :invalid do
    url { nil }
  end
end
