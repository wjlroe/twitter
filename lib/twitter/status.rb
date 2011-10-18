require 'twitter/base'
require 'twitter/creatable'
require 'twitter/geo_factory'
require 'twitter/media_factory'
require 'twitter/metadata'
require 'twitter/place'
require 'twitter/user'
require 'twitter-text'

module Twitter
  class Status < Twitter::Base
    include Twitter::Creatable
    attr_reader :favorited, :from_user, :from_user_id, :geo, :hashtags, :id,
      :in_reply_to_screen_name, :in_reply_to_status_id, :in_reply_to_user_id,
      :iso_language_code, :metadata, :profile_image_url, :media, :place,
      :retweet_count, :retweeted, :source, :text, :to_user, :to_user_id,
      :truncated, :urls, :user, :user_mentions
    alias :favorited? :favorited
    alias :mentions :user_mentions
    alias :retweeted? :retweeted
    alias :truncated? :truncated

    def initialize(status={})
      if geo = status.delete('geo')
        @geo = Twitter::GeoFactory.new(geo)
      end
      @hashtags = Twitter::Extractor.extract_hashtags(status['text']) unless status['text'].nil?
      if media = status['entities'] && status['entities'].delete('media')
        @media = media.map do |medium|
          Twitter::MediaFactory.new(medium)
        end
      end
      if metadata = status.delete('metadata')
        @metadata = Twitter::Metadata.new(metadata)
      end
      if place = status.delete('place')
        @place = Twitter::Place.new(place)
      end
      @urls = Twitter::Extractor.extract_urls(status['text']) unless status['text'].nil?
      if user = status.delete('user')
        @user = Twitter::User.new(user.merge('status' => self.to_hash.delete('user')))
      end
      @user_mentions = Twitter::Extractor.extract_mentioned_screen_names(status['text']) unless status['text'].nil?
      super(status)
    end

    def ==(other)
      super || (other.class == self.class && other.instance_variable_get('@id'.to_sym) == @id)
    end

  end
end
