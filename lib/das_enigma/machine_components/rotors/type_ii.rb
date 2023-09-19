# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    module Rotors
      # This is the Type II rotor
      class TypeII < BaseRotor
        def initialize
          super

          @type = 'II'
          @notch = 'M'
          @turnover = 'E'
          @model = '1'
          @signal_mapping = 'AJDKSIRUXBLHWTMCQGZNPYFVOE'
        end
      end
    end
  end
end
