# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    module Rotors
      # This is the Type VIII rotor
      class TypeVIII < BaseRotor
        def initialize
          super

          @type = 'VIII'
          @notch = 'HU'
          @turnover = 'ZM'
          @model = 'm3 m4 naval'
          @signal_mapping = 'FKQHTLXOCBJSPDZRAMEWNIUYGV'
        end
      end
    end
  end
end
