# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    # The static rotor is the rotor that's fixed in place at the right from the moveable rotors. It passes the output
    # signal from the plugboard to the first moveable rotor. Most static rotors are just the alphabet in sequence, but
    # sometimes a QWERTZ sequence is used (Enigma D, G, KD and the Railway Enigma)
    class StaticRotor
      # Historically correct static rotors, or 'Eintrittzwalze'.
      ROTORS = [
        { type: 'ABCDE', signal_mapping: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' },
        { type: 'QWERT', signal_mapping: 'QWERTZUIOASDFGHJKPYXCVBNML' }
      ].freeze

      def initialize(type:)
        @rotor_hash = find_rotor_by_type(type)
      end

      def input_character(signal_character)
        signal_mapping.find_index { |character| character == signal_character }
      end

      private

      def find_rotor_by_type(rotor_type)
        ROTORS.find { |rotor| rotor[:type] == rotor_type }
      end

      def signal_mapping
        @rotor_hash[:signal_mapping].scan(/\w/)
      end
    end
  end
end
