# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    module Rotors
      # This is the static rotor (Stator, or Eintrittwalze).
      class Static < BaseRotor
        def initialize(ring_setting: 'A', position: 0)
          @type = 'Static'
          @model = ''
          @notch = []
          @turnover = []
          @signal_mapping = ('A'..'Z').to_a

          super
        end
      end
    end
  end
end
