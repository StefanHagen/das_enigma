# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    module Rotors
      # This is the Type IV rotor
      class TypeIV < BaseRotor
        def initialize
          super

          @type = 'IV'
          @notch = 'R'
          @turnover = 'J'
          @model = 'm3'
          @signal_mapping = 'ESOVPZJAYQUIRHXLNFTGKDCMWB'
        end
      end
    end
  end
end
