# frozen_string_literal: true

module DasEnigma
  module MachineComponents
    # The plugboard is a physical machine component that allows you to swap input characters before (and after)
    # encryption. It consisted of a switchboard wich could be used in combination with a special 'double-jack' patch
    # cable. Plugging this one end of the cable (with 2 jacks) into the holes of the letter A, and the other end into
    # the holes of the letter Z, swapped these letters before the signal would get sent through. So with this setup
    # pressing A will send the signal for letter Z to the static rotor. When a substituted signal comes back as a Z, it
    # will get swapped for the letter A.
    class Plugboard
      attr_reader :plugboard

      def initialize(settings: nil)
        @plugboard = setup_plugboard(settings)
      end

      def substitute_ingoing_signal(signal: nil)
        # return nil if signal is nil or not a symbol
        return if signal.nil? || !signal.is_a?(Symbol)

        plugboard[signal].to_sym
      end

      def substitute_outgoing_signal(signal: nil)
        # return nil if signal is nil or not a symbol
        return if signal.nil? || !signal.is_a?(Symbol)

        plugboard[signal].to_sym
      end

      private

      def setup_plugboard(settings)
        plugboard_hash = default_plugboard
        # return default settings if settings are nil or not a hash
        return plugboard_hash if settings.nil? || !settings.is_a?(Hash)

        # remove keys that are not a letter of the alphabet.to_sym and loop through them
        settings.slice(*DasEnigma::Constants::ALPHABET_SYMBOLS).each do |key, value|
          # skip setting if value is already set by another key (the double-jack cables go two ways)
          next if settings.keys.include?(value.to_sym)

          # set both size of the 'patch cable'; setting a -> z, will also mean z -> a
          plugboard_hash[key] = value
          plugboard_hash[value] = key
        end

        plugboard_hash
      end

      def default_plugboard
        {
          a: :a, b: :b, c: :c, d: :d, e: :e, f: :f, g: :g, h: :h, i: :i, j: :j, k: :k, l: :l, m: :m, n: :n, o: :o,
          p: :p, q: :q, r: :r, s: :s, t: :t, u: :u, v: :v, w: :w, x: :x, y: :y, z: :z
        }
      end
    end
  end
end
