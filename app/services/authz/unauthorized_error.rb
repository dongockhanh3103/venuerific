# frozen_string_literal: true

module Authz
  # Raised when permissions are not authorized
  class UnauthorizedError < StandardError

    attr_reader :error_codes

    # @param [Array] error_codes details error that cause unauthorized error
    def initialize(error_codes = [])
      super
      @error_codes = error_codes
    end

  end
end
