# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    module Rotors
      # This is the Type IV rotor
      class TypeIV < BaseRotor
        def initialize(ring_setting: 'A', position: 0)
          super

          @type = 'V'
          @model = 'm3'
          @notches = 'H'.chars
          @turnovers = 'Z'.chars
          @signal_mapping = 'VZBRGITYUPSDNHLXAWMJQOFECK'.chars
        end
      end
    end
  end
end
