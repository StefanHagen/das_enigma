# frozen_string_literal: true

module DasEnigma
  # Here's where it all comes together. The input data goes to the plugboard, through the rotors, gets reflected back
  # through the rotors, through the plugboard and ends up as output. Happy decoding!
  class EnigmaMachine
    attr_accessor :plugboard, :rotors, :reflector
    attr_reader :rotor_count

    def initialize(plugboard:, rotors:, reflector:)
      @plugboard = plugboard
      @rotors = rotors
      @rotor_count = rotors.count
      @reflector = reflector
    end

    def encrypt(signal:)
      # ingoing_substituted_signal = plugboard.substitute_ingoing_signal(signal: signal)
      ingoing_rotor_substitution = rotor_substitution_ingoing(signal: substituted_signal)
      # ... reflector ...
      # outgoing_rotor_substitution = rotor_substitution_outgoing(signal: reflected_signal)
      # outgoing_substituted_signal = plugboard.substitute_outgoing_signal(signal: outgoing_rotor_substitution)
    end

    def decrypt(signal:)

    end

    private

    def rotor_substitution_ingoing(signal:)
      index = -1
      rotor_count.times do |rotor|
        rotors[index].input_signal()
        index += 1
      end
    end

    def rotor_substitution_outgoing(signal:)

    end
  end
end
