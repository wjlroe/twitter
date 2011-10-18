require 'time'

module Twitter
  module Creatable
    attr_reader :created_at

    def initialize(hash={})
      if created_at = hash.delete('created_at')
        @created_at = Time.parse(created_at)
      end
      super(hash)
    end

  end
end
