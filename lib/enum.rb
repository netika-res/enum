require 'enum/token_not_found_error'
require 'enum/init_not_hash_error'
require 'enum/key_in_use_error'
require 'enum/base'
require 'enum/predicates'

module Enum
  def self.[](*ary)
    Class.new(Base) do
      values(*ary)
    end
  end
end