require 'twitter/base'
require 'twitter/creatable'
require 'twitter/user'

module Twitter
  class DirectMessage < Twitter::Base
    include Twitter::Creatable
    attr_reader :id, :recipient, :sender, :text

    def initialize(direct_message={})
      if recipient = direct_message.delete('recipient')
        @recipient = Twitter::User.new(recipient)
      end
      if sender = direct_message.delete('sender')
        @sender = Twitter::User.new(sender)
      end
      super(direct_message)
    end

    def ==(other)
      super || (other.class == self.class && other.instance_variable_get('@id'.to_sym) == @id)
    end

  end
end
