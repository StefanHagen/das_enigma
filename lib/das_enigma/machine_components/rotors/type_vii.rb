# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    module Rotors
      # This is the Type VII rotor
      class TypeVII < BaseRotor
        def initialize
          super

          @type = 'VII'
          @model = 'm3 m4 naval'
          @notch = 'HU'.chars
          @turnover = 'ZM'.chars
          @signal_mapping = 'NZJHGRCXMYSWBOUFAIVLPEKQDT'.chars
        end
      end
    end
  end
end
