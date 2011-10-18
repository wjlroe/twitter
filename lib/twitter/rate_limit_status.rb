require 'twitter/base'

module Twitter
  class RateLimitStatus < Twitter::Base
    attr_reader :hourly_limit, :remaining_hits, :reset_time, :reset_time_in_seconds

    def initialize(rate_limit_status={})
      if reset_time = rate_limit_status.delete('reset_time')
        @reset_time = Time.parse(reset_time)
      end
      super(rate_limit_status)
    end

  end
end
