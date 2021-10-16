# frozen_string_literal: true

module DasEnigma
  module Helpers
    # Typically, Enigma outpout it spaced in blocks of four capitlalized characters.
    class OutputConverter
      def initialize(output_data:)
        @output_data = output_data
      end

      # Split data into chunks of 4 characters and join with a space
      def convert
        @output_data.scan(/.{1,4}/).join(' ')
      end
    end
  end
end
