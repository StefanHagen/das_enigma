# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    module Rotors
      # This is the Type III rotor
      class TypeIII < BaseRotor
        def initialize(ring_setting: 'A', position: 0)
          super

          @type = 'III'
          @model = '1'
          @notch = 'D'.chars
          @turnover = 'V'.chars
          @signal_mapping = 'BDFHJLCPRTXVZNYEIWGAKMUSQO'.chars
        end
      end
    end
  end
end
