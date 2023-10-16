# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    module Rotors
      # This is the Type I rotor
      class TypeI < BaseRotor
        def initialize(ring_setting: 'A', position: 0)
          @type = 'I'
          @model = '1'
          @notch = 'Y'.chars
          @turnover = 'Q'.chars
          @signal_mapping = 'EKMFLGDQVZNTOWYHXUSPAIBRCJ'.chars

          super
        end
      end
    end
  end
end
