# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    # A rotor is a disc that maps an incoming signal to an outgoing signal. For instance a -> z. Different numbers of
    # rotors were used historically, mostly 3 to 4 rotors. In combination with 1 or 2 reflectors and the plugboard, they
    # form the character substitution chain.
    class Rotor
      # Historicaly correct rotors, to be used when assembling your own Enigma machine
      ROTORS = [
        { type: 'STATIC', signal_mapping: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', introduced_in: '1924', model: 'All models' },
        { type: 'I-C', signal_mapping: 'DMTWSILRUYQNKFEJCAZBPGXOHV', introduced_in: '1924', model: 'Commercial Enigma A, B' },
        { type: 'II-C', signal_mapping: 'HQZGPJTMOBLNCIFDYAWVEUSRKX', introduced_in: '1924', model: 'Commercial Enigma A, B' },
        { type: 'III-C', signal_mapping: 'UQNTLSZFMREHDPXKIBVYGJCWOA', introduced_in: '1924', model: 'Commercial Enigma A, B' },
        { type: 'I-R', signal_mapping: 'JGDQOXUSCAMIFRVTPNEWKBLZYH', introduced_in: '7 February 1941', model: 'German Railway (Rocket)' },
        { type: 'II-R', signal_mapping: 'NTZPSFBOKMWRCJDIVLAEYUXHGQ', introduced_in: '7 February 1941', model: 'German Railway (Rocket)' },
        { type: 'III-R', signal_mapping: 'JVIUBHTCDYAKEQZPOSGXNRMWFL', introduced_in: '7 February 1941', model: 'German Railway (Rocket)' },
        { type: 'UKW-R', signal_mapping: 'QYHOGNECVPUZTFDJAXWMKISRBL', introduced_in: '7 February 1941', model: 'German Railway (Rocket)' },
        { type: 'ETW-R', signal_mapping: 'QWERTZUIOASDFGHJKPYXCVBNML', introduced_in: '7 February 1941', model: 'German Railway (Rocket)' },
        { type: 'I-K', signal_mapping: 'PEZUOHXSCVFMTBGLRINQJWAYDK', introduced_in: 'February 1939', model: 'Swiss K' },
        { type: 'II-K', signal_mapping: 'ZOUESYDKFWPCIQXHMVBLGNJRAT', introduced_in: 'February 1939', model: 'Swiss K' },
        { type: 'III-K', signal_mapping: 'EHRVXGAOBQUSIMZFLYNWKTPDJC', introduced_in: 'February 1939', model: 'Swiss K' },
        { type: 'UKW-K', signal_mapping: 'IMETCGFRAYSQBZXWLHKDVUPOJN', introduced_in: 'February 1939', model: 'Swiss K' },
        { type: 'ETW-K', signal_mapping: 'QWERTZUIOASDFGHJKPYXCVBNML', introduced_in: 'February 1939', model: 'Swiss K' },
        { type: 'I', signal_mapping: 'EKMFLGDQVZNTOWYHXUSPAIBRCJ', introduced_in: '1930', model: 'Enigma I' },
        { type: 'II', signal_mapping: 'AJDKSIRUXBLHWTMCQGZNPYFVOE', introduced_in: '1930', model: 'Enigma I' },
        { type: 'III', signal_mapping: 'BDFHJLCPRTXVZNYEIWGAKMUSQO', introduced_in: '1930', model: 'Enigma I' },
        { type: 'IV', signal_mapping: 'ESOVPZJAYQUIRHXLNFTGKDCMWB', introduced_in: 'December 1938', model: 'M3 Army' },
        { type: 'V', signal_mapping: 'VZBRGITYUPSDNHLXAWMJQOFECK', introduced_in: 'December 1938', model: 'M3 Army' },
        { type: 'VI', signal_mapping: 'JPGVOUMFYQBENHZRDKASXLICTW', introduced_in: '1939', model: 'M3 & M4 Naval (FEB 1942)' },
        { type: 'VII', signal_mapping: 'NZJHGRCXMYSWBOUFAIVLPEKQDT', introduced_in: '1939', model: 'M3 & M4 Naval (FEB 1942)' },
        { type: 'VIII', signal_mapping: 'FKQHTLXOCBJSPDZRAMEWNIUYGV', introduced_in: '1939', model: 'M3 & M4 Naval (FEB 1942)' }
      ].freeze

      def initialize(rotor_type: 'STATIC')
        @rotor = setup_rotor(rotor_type)
      end

      private

      def setup_rotor(rotor_type)
        rotor_hash = ROTORS.find { |r| r[:type] == rotor_type }


      end
    end
  end
end
