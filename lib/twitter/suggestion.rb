require 'twitter/base'
require 'twitter/user'

module Twitter
  class Suggestion < Twitter::Base
    attr_reader :name, :size, :slug, :users

    def initialize(suggestion={})
      if users = suggestion.delete('users')
        @users = users.map do |user|
          Twitter::User.new(user)
        end
      end
      super(suggestion)
    end

    def ==(other)
      super || (other.class == self.class && other.instance_variable_get('@slug'.to_sym) == @slug)
    end

  end
end
