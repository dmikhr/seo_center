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

  # когда сайт обрабатывается и данные по www и https еще не получены
  trait :in_progress do
    www { nil }
    https { nil }
  end
end
