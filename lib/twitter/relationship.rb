require 'twitter/base'
require 'twitter/user'

module Twitter
  class Relationship < Twitter::Base
    attr_reader :source, :target

    def initialize(relationship={})
      if source = relationship.delete('source')
        @source = Twitter::User.new(source)
      end
      if target = relationship.delete('target')
        @target = Twitter::User.new(target)
      end
      super(relationship)
    end

  end
end
