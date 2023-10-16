# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    module Rotors
      # This is the Type IV rotor
      class TypeVI < BaseRotor
        def initialize(ring_setting: 'A', position: 0)
          super

          @type = 'VI'
          @model = 'm3 m4 naval'
          @notch = 'HU'.chars
          @turnover = 'ZM'.chars
          @signal_mapping = 'JPGVOUMFYQBENHZRDKASXLICTW'.chars
        end
      end
    end
  end
end
