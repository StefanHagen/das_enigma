# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    module Rotors
      # This is the Type III rotor
      class TypeIII < BaseRotor
        def initialize
          super

          @type = 'III'
          @notch = 'D'
          @turnover = 'V'
          @model = '1'
          @signal_mapping = 'BDFHJLCPRTXVZNYEIWGAKMUSQO'
        end
      end
    end
  end
end
