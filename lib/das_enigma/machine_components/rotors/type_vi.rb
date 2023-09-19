# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    module Rotors
      # This is the Type IV rotor
      class TypeVI < BaseRotor
        def initialize
          super

          @type = 'VI'
          @notch = 'HU'
          @turnover = 'ZM'
          @model = 'm3 m4 naval'
          @signal_mapping = 'JPGVOUMFYQBENHZRDKASXLICTW'
        end
      end
    end
  end
end
