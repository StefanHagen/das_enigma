# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    module Rotors
      # This is the Type II rotor
      class TypeII < BaseRotor
        def initialize
          super

          @type = 'II'
          @model = '1'
          @notch = 'M'.chars
          @turnover = 'E'.chars
          @signal_mapping = 'AJDKSIRUXBLHWTMCQGZNPYFVOE'.chars
        end
      end
    end
  end
end
