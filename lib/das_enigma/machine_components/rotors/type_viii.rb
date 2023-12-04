# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    module Rotors
      # This is the Type VIII rotor
      class TypeVIII < BaseRotor
        def initialize(ring_setting: 'A', position: 0)
          super

          @type = 'VIII'
          @model = 'm3 m4 naval'
          @notches = 'HU'.chars
          @turnovers = 'ZM'.chars
          @signal_mapping = 'FKQHTLXOCBJSPDZRAMEWNIUYGV'.chars
        end
      end
    end
  end
end
