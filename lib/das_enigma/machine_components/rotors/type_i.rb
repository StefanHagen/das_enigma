# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    module Rotors
      # This is the Type I rotor
      class TypeI < BaseRotor
        def initialize
          super

          @type = 'I'
          @notch = 'Y'
          @turnover = 'Q'
          @model = '1'
          @signal_mapping = 'EKMFLGDQVZNTOWYHXUSPAIBRCJ'
        end
      end
    end
  end
end
