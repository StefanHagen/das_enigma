# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    module Rotors
      # This is the Type I rotor
      class TypeI < BaseRotor
        def initialize
          super

          @type = 'I'
          @model = '1'
          @notch = 'Y'.chars
          @turnover = 'Q'.chars
          @signal_mapping = 'EKMFLGDQVZNTOWYHXUSPAIBRCJ'.chars
        end
      end
    end
  end
end
