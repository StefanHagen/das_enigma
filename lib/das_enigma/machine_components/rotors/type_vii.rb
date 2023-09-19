# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    module Rotors
      # This is the Type VII rotor
      class TypeVII < BaseRotor
        def initialize
          super

          @type = 'VII'
          @notch = 'HU'
          @turnover = 'ZM'
          @model = 'm3 m4 naval'
          @signal_mapping = 'NZJHGRCXMYSWBOUFAIVLPEKQDT'
        end
      end
    end
  end
end
