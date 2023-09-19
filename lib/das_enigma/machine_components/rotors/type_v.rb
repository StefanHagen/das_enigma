# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    module Rotors
      # This is the Type IV rotor
      class TypeIV < BaseRotor
        def initialize
          super

          @type = 'V'
          @notch = 'H'
          @turnover = 'Z'
          @model = 'm3'
          @signal_mapping = 'VZBRGITYUPSDNHLXAWMJQOFECK'
        end
      end
    end
  end
end
