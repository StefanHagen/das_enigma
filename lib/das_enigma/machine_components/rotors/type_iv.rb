# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    module Rotors
      # This is the Type IV rotor
      class TypeIV < BaseRotor
        def initialize(ring_setting: 'A', position: 0)
          super

          @type = 'IV'
          @model = 'm3'
          @notch = 'R'.chars
          @turnover = 'J'.chars
          @signal_mapping = 'ESOVPZJAYQUIRHXLNFTGKDCMWB'.chars
        end
      end
    end
  end
end
