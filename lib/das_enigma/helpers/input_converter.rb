# frozen_string_literal: true

module DasEnigma
  module Helpers
    # Any input must be stripped from non A..Z characters, and symbols need to be removed
    class InputConverter
      def initialize(input_data:)
        @input_data = input_data
      end

      # Upcase the sanitized input for uniformity, it also uses the historical convention of using 'X' as a spacing
      # character
      def convert
        @input_data.gsub!(' ', 'X')
        @input_data.scan(/[a-zA-Z]/).join.upcase
      end
    end
  end
end
