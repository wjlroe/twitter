require 'twitter/base'
require 'twitter/user'

module Twitter
  class List < Twitter::Base
    attr_reader :description, :following, :full_name, :id, :member_count,
      :mode, :name, :slug, :subscriber_count, :uri, :user
    alias :following? :following

    def initialize(list={})
      if user = list.delete('user')
        @user = Twitter::User.new(user)
      end
      super(list)
    end

    def ==(other)
      super || (other.class == self.class && other.instance_variable_get('@id'.to_sym) == @id)
    end

  end
end
