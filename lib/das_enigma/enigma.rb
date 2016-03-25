class Enigma

  ALPHABET = ("A".."Z").to_a

  ROTOR_INDEX = { :static => 0, :i => 1, :ii => 2, :iii => 3 }

  ROTORS = []
  ROTORS[0]       = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  ROTORS[1]       = "EKMFLGDQVZNTOWYHXUSPAIBRCJ"
  ROTORS[2]       = "AJDKSIRUXBLHWTMCQGZNPYFVOE"
  ROTORS[3]       = "BDFHJLCPRTXVZNYEIWGAKMUSQO"

  REFLECTORS      = []
  REFLECTORS[0]   = "EJMZALYXVBWFCRQUONTSPIKHGD"
  REFLECTORS[1]   = "YRUHQSLDPXNGOKMIEBFZCWVJAT"
  REFLECTORS[2]   = "FVPJIAOYEDRZXWGCTKUQSBNMHL"

  def initialize(file_path)

    # Reading the unencrypted data from a file
    file = File.open(File.expand_path(file_path), 'r')
    raw_text = file.read
    file.close

    @raw_text = raw_text

    @plugboard_settings = [ ["A", "M"], ["F", "I"], ["N", "V"], ["P", "S"], ["T", "U"], ["W", "Z"] ]
    @rotor_settings = { :rotor_types => ["II", "I", "III"], :rotor_positions => [ "A", "B", "L" ], :rotor_notches => ["X", "M", "V"] }
    @reflector_settings = { :reflector_type => 0 }

  end

  # Normalize the input text, setup the rotors and reflectors, and run the message
  def encode
    self.normalize_raw_text(@raw_text)
    self.setup_rotors(@rotor_settings)
    self.setup_reflector(@reflector_settings)

    # Pass each character through the 'Enigma machine'
    char_index = 0
    @normalized_text.each_char do |character|
        if char_index < 1
          self.press_key(character)
        end
      char_index += 1
    end
  end

  # Removes unwanted characters and spaces
  def normalize_raw_text(raw_text)
    normalized_text = raw_text.gsub(/\W+/, '')
    normalized_text.upcase!
    @normalized_text = normalized_text
  end

  # Maps the chosen rotors to the alphabet, and rotates them to their starting positions.
  def setup_rotors(rotor_settings)
    @mapped_rotors = []
    ROTORS.each_with_index do |rotor, index|
      mapped_rotor_array = []
      rotor_array = []
      char_count = 0
      rotor.each_char do |character|
        char_hash = {}
        char_hash = { ALPHABET[char_count] => character.to_s }
        rotor_array << char_hash
        char_count += 1
      end
      mapped_rotor_array = rotor_array
      @mapped_rotors << mapped_rotor_array
    end

    static_rotor_index = ROTOR_INDEX[:static]
    first_rotor_type = rotor_settings[:rotor_types][0].downcase!.to_sym if rotor_settings[:rotor_types][0]
    first_rotor_index = ROTOR_INDEX[first_rotor_type] if first_rotor_type
    second_rotor_type = rotor_settings[:rotor_types][1].downcase!.to_sym if rotor_settings[:rotor_types][1]
    second_rotor_index = ROTOR_INDEX[second_rotor_type] if second_rotor_type
    third_rotor_type = rotor_settings[:rotor_types][2].downcase!.to_sym if rotor_settings[:rotor_types][2]
    third_rotor_index = ROTOR_INDEX[third_rotor_type] if third_rotor_type
    fourth_rotor_type = rotor_settings[:rotor_types][3].downcase!.to_sym if rotor_settings[:rotor_types][3]
    fourth_rotor_index = ROTOR_INDEX[fourth_rotor_type] if fourth_rotor_type

    static_rotor = @mapped_rotors[static_rotor_index] if static_rotor_index
    first_rotor = @mapped_rotors[first_rotor_index] if first_rotor_index
    second_rotor = @mapped_rotors[second_rotor_index] if second_rotor_index
    third_rotor = @mapped_rotors[third_rotor_index] if third_rotor_index
    fourth_rotor = @mapped_rotors[fourth_rotor_index] if fourth_rotor_index

    @first_rotor_position = ALPHABET.index(@rotor_settings[:rotor_positions][0]) if @rotor_settings[:rotor_positions][0]
    @second_rotor_position = ALPHABET.index(@rotor_settings[:rotor_positions][1]) if @rotor_settings[:rotor_positions][1]
    @third_rotor_position = ALPHABET.index(@rotor_settings[:rotor_positions][2]) if @rotor_settings[:rotor_positions][2]
    @fourth_rotor_position = ALPHABET.index(@rotor_settings[:rotor_positions][3]) if @rotor_settings[:rotor_positions][3]

    @static_rotor = static_rotor
    @first_rotor = first_rotor.rotate(@first_rotor_position) if first_rotor && @first_rotor_position
    @second_rotor = second_rotor.rotate(@second_rotor_position) if second_rotor && @second_rotor_position
    @third_rotor = third_rotor.rotate(@third_rotor_position) if third_rotor && @third_rotor_position
    @fourth_rotor = fourth_rotor.rotate(@fourth_rotor_position) if fourth_rotor && @fourth_rotor_position
  end

  # Maps the chosen reflector to the alphabet.
  def setup_reflector(reflector_settings)
    @mapped_reflectors = []
    REFLECTORS.each_with_index do |reflector, index|
      mapped_reflector_array = []
      reflector_array = []
      char_count = 0
      reflector.each_char do |character|
        char_hash = {}
        char_hash = { ALPHABET[char_count] => character.to_s }
        reflector_array << char_hash
        char_count += 1
      end
      mapped_reflector_array = reflector_array
      @mapped_reflectors[index] = mapped_reflector_array
    end
    @reflector = @mapped_reflectors[reflector_settings[:reflector_type]]
  end

  # What to execute when a key is pressed
  def press_key(character)
    self.step_rotors
    plugboard_out_character = self.plugboard_in(@plugboard_settings, character)
    puts "| plugboard_out_character | " + plugboard_out_character
    static_rotor_char_position = self.static_rotor_forward(plugboard_out_character)
    puts "| static_rotor_char_position | " + @static_rotor[static_rotor_char_position].keys.first
    first_rotor_char_position = self.first_rotor_forward(static_rotor_char_position)
    puts "| first_rotor_char_position | " + @first_rotor[first_rotor_char_position].keys.first
    second_rotor_char_position = self.second_rotor_forward(first_rotor_char_position)
    puts "| second_rotor_char_position | " + @second_rotor[second_rotor_char_position].keys.first
    third_rotor_char_position = self.third_rotor_forward(second_rotor_char_position)
    puts "| third_rotor_char_position | " + @third_rotor[third_rotor_char_position].keys.first
    reflector_char_position = self.reflector_in(third_rotor_char_position)
    puts "| reflector_char_position | " + @reflector[reflector_char_position].keys.first
    third_rotor_back_char_position = self.third_rotor_backward(reflector_char_position)
    puts "| third_rotor_char_position | " + @third_rotor[third_rotor_back_char_position].keys.first
    second_rotor_char_position = self.second_rotor_backward(third_rotor_char_position)
    puts "| second_rotor_char_position | " + @second_rotor[second_rotor_char_position].keys.first
    first_rotor_char_position = self.first_rotor_backward(second_rotor_char_position)
    puts "| first_rotor_char_position | " + @first_rotor[first_rotor_char_position].keys.first
    static_rotor_backward_char = self.static_rotor_backward(first_rotor_char_position)
    puts "| static_rotor_backward_char | " + static_rotor_backward_char
    plugboard_out_character = self.plugboard_out(@plugboard_settings, static_rotor_backward_char)
    puts "| plugboard_out_character | " + plugboard_out_character
  end

  # Passes a character through the plugboard
  def plugboard_in(plugboard_settings, character)
    plug_keys = []
    plugboard_settings.each do |plug_pair|
      plug_keys << plug_pair[0]
    end
    if plug_keys.index(character)
      output_character = plugboard_settings[plug_keys.index(character)][1]
    else
      output_character = character
    end
    return output_character.to_s
  end

  def static_rotor_forward(character)
    static_rotor_keys = []
    static_rotor_values = []
    @static_rotor.each do |hash|
      hash.each do |key, value|
        static_rotor_keys << key
        static_rotor_values << value
      end
    end
    char_position = static_rotor_keys.index(character)
    new_char = static_rotor_values[char_position]
    exit_position = static_rotor_keys.index(new_char)
    return exit_position
  end

  def static_rotor_backward(char_position)
    static_rotor_keys = []
    static_rotor_values = []
    @static_rotor.each do |hash|
      hash.each do |key, value|
        static_rotor_keys << key
        static_rotor_values << value
      end
    end
    new_char = static_rotor_values[char_position]
    exit_position = static_rotor_keys.index(new_char)
    exit_character = static_rotor_keys[exit_position].to_s
    return exit_character
  end

  def first_rotor_forward(char_position)
    first_rotor_keys = []
    first_rotor_values = []
    @first_rotor.each do |hash|
      hash.each do |key, value|
        first_rotor_keys << key
        first_rotor_values << value
      end
    end
    new_char = first_rotor_values[char_position]
    exit_position = first_rotor_keys.index(new_char)
    return exit_position
  end

  def second_rotor_forward(char_position)
    second_rotor_keys = []
    second_rotor_values = []
    @second_rotor.each do |hash|
      hash.each do |key, value|
        second_rotor_keys << key
        second_rotor_values << value
      end
    end
    new_char = second_rotor_values[char_position]
    exit_position = second_rotor_keys.index(new_char)
    return exit_position
  end

  def third_rotor_forward(char_position)
    third_rotor_keys = []
    third_rotor_values = []
    @third_rotor.each do |hash|
      hash.each do |key, value|
        third_rotor_keys << key
        third_rotor_values << value
      end
    end
    new_char = third_rotor_values[char_position]
    exit_position = third_rotor_keys.index(new_char)
    return exit_position
  end

  def fourth_rotor_forward(char_position)
    fourth_rotor_keys = []
    fourth_rotor_values = []
    @fourth_rotor.each do |hash|
      hash.each do |key, value|
        fourth_rotor_keys << key
        fourth_rotor_values << value
      end
    end
    new_char = fourth_rotor_values[char_position]
    exit_position = fourth_rotor_keys.index(new_char)
    return exit_position
  end

  def reflector_in(char_position)
    reflector_keys = []
    reflector_values = []
    @reflector.each do |hash|
      hash.each do |key, value|
        reflector_keys << key
        reflector_values << value
      end
    end
    new_char = reflector_values[char_position]
    exit_position = reflector_keys.index(new_char)
    return exit_position
  end

  def fourth_rotor_backward(char_position)
    fourth_rotor_keys = []
    fourth_rotor_values = []
    @fourth_rotor.each do |hash|
      hash.each do |key, value|
        fourth_rotor_keys << key
        fourth_rotor_values << value
      end
    end
    new_char = fourth_rotor_values[char_position]
    exit_position = fourth_rotor_keys.index(new_char)
    return exit_position
  end

  def third_rotor_backward(char_position)
    third_rotor_keys = []
    third_rotor_values = []
    @third_rotor.each do |hash|
      hash.each do |key, value|
        third_rotor_keys << key
        third_rotor_values << value
      end
    end
    new_char = third_rotor_values[char_position]
    exit_position = third_rotor_keys.index(new_char)
    return exit_position
  end

  def second_rotor_backward(char_position)
    second_rotor_keys = []
    second_rotor_values = []
    @second_rotor.each do |hash|
      hash.each do |key, value|
        second_rotor_keys << key
        second_rotor_values << value
      end
    end
    new_char = second_rotor_values[char_position]
    exit_position = second_rotor_keys.index(new_char)
    return exit_position
  end

  def first_rotor_backward(char_position)
    first_rotor_keys = []
    first_rotor_values = []
    @first_rotor.each do |hash|
      hash.each do |key, value|
        first_rotor_keys << key
        first_rotor_values << value
      end
    end
    new_char = first_rotor_values[char_position]
    exit_position = first_rotor_keys.index(new_char)
    return exit_position
  end

  def plugboard_out(plugboard_settings, character)
    plug_keys = []
    plug_values = []
    plugboard_settings.each do |plug_pair|
      plug_keys << plug_pair[0]
      plug_values << plug_pair[1]
    end
    if plug_values.index(character)
      output_character = plugboard_settings[plug_values.index(character)][0]
    else
      output_character = character
    end
    return output_character.to_s
  end

  def step_rotors
    first_rotor_keys = []
    @first_rotor.each_with_index do |hash, index|
      first_rotor_keys << hash.keys.first
    end
    @first_notch_position = first_rotor_keys.index(@rotor_settings[:rotor_notches][0])
    if @first_notch_position == @first_rotor_position
      self.double_step_first_rotor
    else
      self.step_first_rotor
    end
  end

  def step_first_rotor
    if @first_rotor_position >= 25
      @first_rotor_position = 0
      @first_rotor.rotate!(@first_rotor_position)
      self.step_second_rotor
    else
      @first_rotor_position += 1
      @first_rotor.rotate!(@first_rotor_position)
    end
  end

  def double_step_first_rotor
    if @first_rotor_position == 24
      @first_rotor_position = 0
      @first_rotor.rotate!(@first_rotor_position)
      self.double_step_second_rotor
    elsif @first_rotor_position >= 25
      @first_rotor_position = 1
      @first_rotor.rotate!(@first_rotor_position)
      self.double_step_second_rotor
    else
      @first_rotor_position += 2
      @first_rotor.rotate!(@first_rotor_position)
      self.double_step_second_rotor
    end
  end

  def step_second_rotor
    if @second_rotor_position >= 25
      @second_rotor_position = 0
      @second_rotor.rotate!(@second_rotor_position)
      self.step_third_rotor
    else
      @second_rotor_position += 1
      @second_rotor.rotate!(@second_rotor_position)
    end
  end

  def double_step_second_rotor
    if @second_rotor_position == 24
      @second_rotor_position = 0
      @second_rotor.rotate!(@second_rotor_position)
      self.double_step_third_rotor
    elsif @second_rotor_position >= 25
      @second_rotor_position = 1
      @second_rotor.rotate!(@second_rotor_position)
      self.double_step_third_rotor
    else
      @first_rotor_position += 2
      @first_rotor.rotate!(@second_rotor_position)
      self.double_step_third_rotor
    end
  end

  def step_third_rotor
    if @third_rotor_position >= 25
      @third_rotor_position = 0
      @third_rotor.rotate!(@third_rotor_position)
    else
      @third_rotor_position += 1
      @third_rotor.rotate!(@third_rotor_position)
    end
  end

  def double_step_third_rotor
    if @third_rotor_position == 24
      @third_rotor_position = 0
      @third_rotor.rotate!(@third_rotor_position)
    elsif @third_rotor_position >= 25
      @third_rotor_position = 1
      @third_rotor.rotate!(@third_rotor_position)
    else
      @third_rotor_position += 2
      @third_rotor.rotate!(@third_rotor_position)
    end
  end

end