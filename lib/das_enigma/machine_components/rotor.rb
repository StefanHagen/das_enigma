# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    # A rotor is a disc that maps an incoming signal to an outgoing signal. For instance a -> z. Different numbers of
    # rotors were used historically, mostly 3 to 4 rotors. In combination with 1 or 2 reflectors and the plugboard, they
    # form the character substitution chain.
    class Rotor
      # Historicaly correct rotors, to be used when assembling your own Enigma machine
      ROTORS = [
        { type: 'I', notch: 'Y', turnover: 'Q', model: 'Enigma I', signal_mapping: 'EKMFLGDQVZNTOWYHXUSPAIBRCJ' },
        { type: 'II', notch: 'M', turnover: 'E', model: 'Enigma I', signal_mapping: 'AJDKSIRUXBLHWTMCQGZNPYFVOE' },
        { type: 'III', notch: 'D', turnover: 'V', model: 'Enigma I', signal_mapping: 'BDFHJLCPRTXVZNYEIWGAKMUSQO' },
        { type: 'IV', notch: 'R', turnover: 'J', model: 'Enigma M3', signal_mapping: 'ESOVPZJAYQUIRHXLNFTGKDCMWB' },
        { type: 'V', notch: 'H', turnover: 'Z', model: 'Enigma M3', signal_mapping: 'VZBRGITYUPSDNHLXAWMJQOFECK' },
        {
          type: 'VI',
          notch: 'HU',
          turnover: 'ZM',
          model: 'Enigma M3 & M4 Naval',
          signal_mapping: 'JPGVOUMFYQBENHZRDKASXLICTW'
        },
        {
          type: 'VII',
          notch: 'HU',
          turnover: 'ZM',
          model: 'Enigma M3 & M4 Naval',
          signal_mapping: 'NZJHGRCXMYSWBOUFAIVLPEKQDT'
        },
        {
          type: 'VIII',
          notch: 'HU',
          turnover: 'ZM',
          model: 'Enigma M3 & M4 Naval',
          signal_mapping: 'FKQHTLXOCBJSPDZRAMEWNIUYGV'
        }
      ].freeze

      # The position array is used to easily rotate positional numbers up to and including 26
      POSITION_ARRAY = (1..26).to_a.freeze
      ALPHABET_ARRAY = ('A'..'Z').to_a.freeze

      attr_reader :notch

      def initialize(type:, ring_setting: 'A', position: 1)
        @rotor_hash = find_rotor_by_type(type)
        @ring_setting = ALPHABET_ARRAY.find_index(ring_setting) + 1
        @position_array = POSITION_ARRAY.rotate(position - 1)
        @notches = @rotor_hash[:notch]
      end

      def input_signal(signal_position)
        signal_mapping.rotate(@position_array.first - 1)[signal_position - 1]
      end

      def step_rotor
        @position_array.rotate!
      end

      private

      def find_rotor_by_type(rotor_type)
        ROTORS.find { |rotor| rotor[:type] == rotor_type }
      end

      def signal_mapping
        @rotor_hash[:signal_mapping].scan(/\w/)
      end

      def turnover_points
        @rotor_hash[:turnover].scan(/\w/)
      end
    end
  end
end
