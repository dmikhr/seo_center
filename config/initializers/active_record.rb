# https://railsguides.net/skip-callbacks-in-tests/
class ActiveRecord::Base
  cattr_accessor :skip_callbacks
end

# ActiveRecord::Base.skip_callbacks = false
