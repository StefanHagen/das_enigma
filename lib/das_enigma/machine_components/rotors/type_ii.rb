# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    module Rotors
      # This is the Type II rotor
      class TypeII < BaseRotor
        def initialize(ring_setting: 'A', position: 0)
          super

          @type = 'II'
          @model = '1'
          @notches = 'M'.chars
          @turnovers = 'E'.chars
          @signal_mapping = 'AJDKSIRUXBLHWTMCQGZNPYFVOE'.chars
        end
      end
    end
  end
end
