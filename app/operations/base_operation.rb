# frozen_string_literal: true

class BaseOperation

  # A syntactic sugar to support call #execute directly instead of
  # new object then call #execute on that object
  #
  # @example
  # Instead of
  #   Operation.new(param1, param2).execute
  #
  # It can just
  #   Operation.execute(param1, param2)
  def self.execute(*args, &block)
    new(*args, &block).execute
  end

end
