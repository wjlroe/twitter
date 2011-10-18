require 'active_support/core_ext/enumerable'
require 'twitter/base'
require 'twitter/size'

module Twitter
  class Photo < Twitter::Base
    attr_reader :display_url, :expanded_url, :id, :indices, :media_url,
      :media_url_https, :sizes, :url

    def initialize(photo={})
      if sizes = photo.delete('sizes')
        @sizes = sizes.each_with_object({}) do |(key, value), object|
          object[key] = Twitter::Size.new(value)
        end
      end
      super(photo)
    end

    def ==(other)
      super || (other.class == self.class && other.instance_variable_get('@id'.to_sym) == @id)
    end

  end
end
