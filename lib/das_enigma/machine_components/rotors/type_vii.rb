# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    module Rotors
      # This is the Type VII rotor
      class TypeVII < BaseRotor
        def initialize(ring_setting: 'A', position: 0)
          super

          @type = 'VII'
          @model = 'm3 m4 naval'
          @notches = 'HU'.chars
          @turnovers = 'ZM'.chars
          @signal_mapping = 'NZJHGRCXMYSWBOUFAIVLPEKQDT'.chars
        end
      end
    end
  end
end
