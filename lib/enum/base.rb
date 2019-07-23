require 'set'

module Enum
  class Base < BasicObject
    class << self
      def inherited(child)
        return if self == Enum

        init_child_class(child)
      end

      def values(*ary)
        add_value(ary.first) if ary.first
      end

      def all
        history.to_a
      end

      def indexes
        (0...store.size).to_a
      end

      def include?(token)
        history.include?(token.to_sym)
      end

      def enums(*tokens)
        tokens.map { |token| enum(token) }
      end

      def enum(t)
        exists(t.to_sym)
        t.to_sym
      end

      def real_enum(t)
        ts = t.to_sym
        store[index(t)]
      end

      def exists(token)
        unless history.include?(token.to_sym)
          raise(TokenNotFoundError, "Token '#{token}' not found in #{self}")
        end
      end

      def value(t)
        e = real_enum(t)
        e[t]
      end

      def find_value(v)
        key = nil
        store.each do |e|
          key = e.keys[0] if e.values[0] == v
        end
        unless key
          raise(TokenNotFoundError, "Token for value '#{v}' not found in #{self}")
        end
        enum(key)
      end

=begin
      def name(t)
        translate(enum(t))
      end
=end
      def index(token)
        exists(token)
        store.index do |h|
          key, value = h.first
          key == token.to_sym
        end
      end

      protected

      def store
        @store ||= Array.new
      end

      def store=(ary)
        @store = ary
      end

      def history
        @history ||= Set.new
      end

      def history=(set)
        @history = set
      end

=begin
      def translate(token, options = {})
        I18n.t(token, scope: "enum.#{self}", exception_handler: proc do
          if superclass == Enum::Base
            I18n.t(token, options.merge(scope: "enum.#{self}"))
          else
            superclass.translate(token, exception_handler: proc do
              I18n.t(token, scope: "enum.#{self}")
            end)
          end
        end)
      end
=end
      private

      def add_value(val)
        raise(InitNotHashError, "'#{val}' is not a hash and cannot be processed") unless val.is_a? Hash
        val.each do |newKey, newValue|
          raise(KeyInUseError, "'#{key}' is already a key existing in enum") if history.include?(newKey.to_sym)
          store.push(Hash[newKey, newValue])
          history.add(newKey)
        end
      end

      def init_child_class(child)
        child.store = self.store.clone
        child.history = self.history.clone
      end

    end
  end
end