# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    module Rotors
      # This is the Type IV rotor
      class TypeIV < BaseRotor
        def initialize
          super

          @type = 'V'
          @model = 'm3'
          @notch = 'H'.chars
          @turnover = 'Z'.chars
          @signal_mapping = 'VZBRGITYUPSDNHLXAWMJQOFECK'.chars
        end
      end
    end
  end
end
