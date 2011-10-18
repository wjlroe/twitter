require 'active_support/core_ext/kernel/singleton_class'
require 'twitter/base'

module Twitter
  class Cursor < Twitter::Base
    attr_reader :collection, :next_cursor, :previous_cursor
    alias :next :next_cursor
    alias :previous :previous_cursor

    def initialize(cursor, method, klass=nil)
      if collection = cursor.delete(method.to_s)
        @collection = collection.map do |item|
          if klass
            klass.new(item)
          else
            item
          end
        end
      end
      singleton_class.class_eval do
        alias_method method.to_sym, :collection
      end
      super(cursor)
    end

    def first?
      @previous_cursor.zero?
    end
    alias :first :first?

    def last?
      @next_cursor.zero?
    end
    alias :last :last?

  end
end
