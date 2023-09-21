# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    module Rotors
      # A rotor is a disc that maps an incoming signal to an outgoing signal. For instance A -> G. Different numbers of
      # rotors were used historically, mostly 3 to 4 rotors. In combination with 1 or 2 reflectors and the plugboard,
      # they form the character substitution chain.
      class BaseRotor
        attr_reader :type, :model, :notch, :turnover, :alphabet_mapping, :signal_mapping, :positional_mapping,
                    :ring_setting, :position

        attr_accessor :primed_for_stepping

        POSITIONAL_MAPPING = (0..25).to_a.freeze
        ALPHABET_MAPPING = ('A'..'Z').to_a.freeze

        def initialize(ring_setting: 'A', position: 0)
          @ring_setting = ring_setting
          @position = position
          @alphabet_mapping = ALPHABET_MAPPING
          @positional_mapping = POSITIONAL_MAPPING
          @primed_for_stepping = false
        end

        def signal_forward(signal_position:)
          step_rotor if primed_for_stepping

          signal_forward
        end

        def signal_reverse(signal_position:)
          signal_reverse
        end

        private

        def step_rotor
          positional_mapping.rotate!
        end

        def ring_setting_index
          @ring_setting_index ||= ALPHABET_MAPPING.find_index(ring_setting)
        end
      end
    end
  end
end
