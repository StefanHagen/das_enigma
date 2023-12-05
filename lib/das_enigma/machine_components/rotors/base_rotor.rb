# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    module Rotors
      # A rotor is a disc that maps an incoming signal to an outgoing signal. For instance A -> G. Different numbers of
      # rotors were used historically, mostly 3 to 4 rotors. In combination with 1 or 2 reflectors and the plugboard,
      # they form the character substitution chain.
      class BaseRotor
        attr_reader :type, :model, :notches, :turnover, :alphabet_mapping, :signal_mapping, :positional_mapping,
                    :ring_setting, :position

        def initialize(ring_setting:, position:)
          @ring_setting = ring_setting
          @position = position
          @alphabet_mapping = ('A'..'Z').to_a
          @positional_mapping = (0..25).to_a
          @primed_for_stepping = false

          set_alphabet_ring
          set_rotor_position
        end

        def signal_forward(signal_position:)
          outgoing_character = @signal_mapping[signal_position]
          @alphabet_mapping.index(outgoing_character)
        end

        def signal_reverse(signal_position:)
          # Signal reverse
        end

        def in_notch_position?
          notch_positions = @notches.map { |notch| alphabet_mapping.index(notch) }
          notch_positions.include?(positional_mapping.first.to_i)
        end

        def in_turnover_position?
          notch_positions = @turnovers.map { |turnover| alphabet_mapping.index(turnover) }
          notch_positions.include?(positional_mapping.first.to_i)
        end

        def step_rotor
          @positional_mapping.rotate!
          @alphabet_mapping.rotate!
          @signal_mapping.rotate!
        end

        private

        def set_alphabet_ring
          ring_index = @alphabet_mapping.index(@ring_setting)
          @alphabet_mapping.rotate!(ring_index)
        end

        def set_rotor_position
          position_index = @positional_mapping.index(@position)
          @alphabet_mapping.rotate!(position_index)
        end
      end
    end
  end
end
