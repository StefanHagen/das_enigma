class Encryption

  ALPHABET = ("A".."Z").to_a

  ROTOR_INDEX = { :static => 0, :i => 1, :ii => 2, :iii => 3 }

  ROTORS          = []
  ROTORS[0]       = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split(//)
  ROTORS[1]       = "EKMFLGDQVZNTOWYHXUSPAIBRCJ".split(//)
  ROTORS[2]       = "AJDKSIRUXBLHWTMCQGZNPYFVOE".split(//)
  ROTORS[3]       = "BDFHJLCPRTXVZNYEIWGAKMUSQO".split(//)

  REFLECTORS      = []
  REFLECTORS[0]   = "EJMZALYXVBWFCRQUONTSPIKHGD".split(//)
  REFLECTORS[1]   = "YRUHQSLDPXNGOKMIEBFZCWVJAT".split(//)
  REFLECTORS[2]   = "FVPJIAOYEDRZXWGCTKUQSBNMHL".split(//)

  def initialize(file_path)

    # Reading the unencrypted data from a file
    file = File.open(File.expand_path(file_path), 'r')
    unencrypted_data = file.read
    file.close

    @unencrypted_data = unencrypted_data
    @plugboard_settings = [ ["A", "M"], ["F", "I"], ["N", "V"], ["P", "S"], ["T", "U"], ["W", "Z"] ]
    @rotor_settings = { :rotor_types => ["II", "I", "III"], :rotor_positions => [ "A", "B", "L" ], :rotor_notches => ["X", "M", "V"] }
    @reflector_settings = { :reflector_type => 0 }
  end

  def encrypt
    self.normalize_unencrypted_data(@unencrypted_data)
    self.setup_rotors(@rotor_settings)
    self.setup_reflector(@reflector_settings)

    puts "method: encrypt | String to encrypt: " + @normalized_data

    self.plugboard_in(@plugboard_settings)
    # self.first_rotor_forward(@plugboard_in_result)
    # self.plugboard_out(@plugboard_settings)
  end

  def normalize_unencrypted_data(unencrypted_data)
    normalized_data = unencrypted_data.gsub(/\W+/, '')
    normalized_data.upcase!
    @normalized_data = normalized_data
  end

  def setup_rotors(rotor_settings)
    first_rotor_type = @rotor_settings[:rotor_types][0].downcase!.to_sym
    first_rotor_index = ROTOR_INDEX[first_rotor_type]
    second_rotor_type = @rotor_settings[:rotor_types][1].downcase!.to_sym
    second_rotor_index = ROTOR_INDEX[second_rotor_type]
    third_rotor_type = @rotor_settings[:rotor_types][2].downcase!.to_sym
    third_rotor_index = ROTOR_INDEX[third_rotor_type]
    fourth_rotor_type = @rotor_settings[:rotor_types][3].downcase!.to_sym if @rotor_settings[:rotor_types].count > 3
    fourth_rotor_index = ROTOR_INDEX[fourth_rotor_type] if @rotor_settings[:rotor_types].count > 3

    # Load the right rotors into the variables based on ROTOR_INDEX
    first_rotor = ROTORS[first_rotor_index] if first_rotor_index
    second_rotor = ROTORS[second_rotor_index] if second_rotor_index
    third_rotor = ROTORS[third_rotor_index] if third_rotor_index
    fourth_rotor = ROTORS[fourth_rotor_index] if fourth_rotor_index

    # Rotate the rotors based on the rotor_settings position values
    first_position_index = ALPHABET.index(@rotor_settings[:rotor_positions][0]) if first_rotor && @rotor_settings[:rotor_positions][0]
    second_position_index = ALPHABET.index(@rotor_settings[:rotor_positions][1]) if second_rotor && @rotor_settings[:rotor_positions][1]
    third_position_index = ALPHABET.index(@rotor_settings[:rotor_positions][2]) if third_rotor && @rotor_settings[:rotor_positions][2]
    fourth_position_index = ALPHABET.index(@rotor_settings[:rotor_positions][3]) if fourth_rotor && @rotor_settings[:rotor_positions][3]

    @first_rotor = first_rotor.rotate(first_position_index) if first_position_index
    @second_rotor = second_rotor.rotate(second_position_index) if second_position_index
    @third_rotor = third_rotor.rotate(third_position_index) if third_position_index
    @fourth_rotor = fourth_rotor.rotate(fourth_position_index) if fourth_position_index

    @first_rotor_step_count = first_position_index if first_position_index
    @second_rotor_step_count = second_position_index if second_position_index
    @third_rotor_step_count = third_position_index if third_position_index
    @fourth_rotor_step_count = fourth_position_index if fourth_position_index
  end

  def setup_reflector(reflector_settings)
    @reflector = REFLECTORS[@reflector_settings[:reflector_type]]
  end

  def plugboard_in(plugboard_settings)
    @plugboard_in_result = @normalized_data
    puts "method: plugboard_in | Plugboard input: " + @plugboard_in_result
    plugboard_settings.each do |plug|
      @plugboard_in_result = @plugboard_in_result.gsub(plug[0], plug[1])
    end
    puts "method: plugboard_in | Plugboard output: " + @plugboard_in_result
    first_rotor_forward(@plugboard_in_result)
  end

  def step_first_rotor_forward
    if @first_rotor
      notch = ALPHABET.index(@rotor_settings[:rotor_notches][1])
      if @first_rotor_step_count == ALPHABET[notch]
        @first_rotor.rotate!(2)
        @first_rotor_step_count = @first_rotor_step_count + 2
      else
        @first_rotor.rotate!(1)
        @first_rotor_step_count = @first_rotor_step_count + 1
      end
      if @first_rotor_step_count >= 27
        @first_rotor_step_count = 0
        step_second_rotor_forward
      end
    end
  end

  def step_second_rotor_forward
    if @second_rotor
      @second_rotor.rotate!(1)
      @second_rotor_step_count = @second_rotor_step_count + 1
      if @second_rotor_step_count >= 27
        @second_rotor_step_count = 0
        step_third_rotor_forward
      end
    end
  end

  def step_third_rotor_forward
    if @third_rotor
      @third_rotor.rotate!(1)
      @third_rotor_step_count = @third_rotor_step_count + 1
      if @third_rotor_step_count >= 27
        @third_rotor_step_count = 0
        step_fourth_rotor_forward
      end
    end
  end

  def step_fourth_rotor_forward
    if @fourth_rotor
      @fourth_rotor.rotate!(1)
      @fourth_rotor_step_count = @fourth_rotor_step_count + 1
      if @fourth_rotor_step_count >= 27
        @fourth_rotor_step_count = 0
      end
    else
      puts "No Fourth Rotor"
    end
  end

  def first_rotor_forward(plugboard_in_result)
    if @first_rotor
      @first_rotor_forward_result = ""
      plugboard_in_result.each_char do |character|
        step_first_rotor_forward
        char_index = ALPHABET.index(character)
        @first_rotor_forward_result += @first_rotor[char_index]
      end
      puts "method: first_rotor_forward | First rotor output: " + @first_rotor_forward_result
      second_rotor_forward(@first_rotor_forward_result)
    else
      puts "--- First rotor not set: skipping to second rotor ---"
      second_rotor_forward(plugboard_in_result)
    end
  end

  def second_rotor_forward(first_rotor_forward_result)
    if @second_rotor
      @second_rotor_forward_result = ""
      first_rotor_forward_result.each_char do |character|
        char_index = ALPHABET.index(character)
        char_index = char_index + @first_rotor_step_count
        @second_rotor_forward_result += @second_rotor[char_index]
      end
      puts "method: second_rotor_forward | Second rotor output: " + @second_rotor_forward_result
      third_rotor_forward(@second_rotor_forward_result)
    else
      puts "--- Second rotor not set: skipping to third rotor ---"
      third_rotor_forward(first_rotor_forward_result)
    end
  end

  def third_rotor_forward(second_rotor_forward_result)
    if @third_rotor
      @third_rotor_forward_result = ""
      second_rotor_forward_result.each_char do |character|
        char_index = ALPHABET.index(character)
        char_index = char_index + @second_rotor_step_count
        @third_rotor_forward_result += @third_rotor[char_index]
      end
      puts "method: third_rotor_forward | Third rotor output: " + @third_rotor_forward_result
      fourth_rotor_forward(@third_rotor_forward_result)
    else
      puts "--- Third rotor not set: skipping to fourth rotor ---"
      fourth_rotor_forward(second_rotor_forward_result)
    end
  end

  def fourth_rotor_forward(third_rotor_forward_result)
    if @fourth_rotor
      @fourth_rotor_forward_result = ""
      third_rotor_forward_result.each_char do |character|
        char_index = ALPHABET.index(character)
        char_index = char_index + @third_rotor_step_count
        @fourth_rotor_forward_result += @fourth_rotor[char_index]
      end
      puts "method: fourth_rotor_forward | Fourth rotor output: " + @fourth_rotor_forward_result
      reflect(@fourth_rotor_forward_result)
    else
      puts "--- Fourth rotor not set: skipping to reflector ---"
      reflect(third_rotor_forward_result)
    end
  end

  def reflect(fourth_rotor_forward_result)
    puts "method: reflect | Reflector input: " + fourth_rotor_forward_result
    @reflected_output = ""
    fourth_rotor_forward_result.each_char do |character|
      char_index = ALPHABET.index(character)
      @reflected_output += @reflector[char_index]
    end
    puts "method: reflect | Reflector output | " + @reflected_output
    fourth_rotor_backward(@reflected_output)
  end

  def fourth_rotor_backward(reflected_output)
    if @fourth_rotor
      @fourth_rotor_backward_result = ""
      reflected_output.each_char do |character|
        char_index = ALPHABET.index(character)
        back_char = @fourth_rotor[char_index]
        new_index = ALPHABET.index(back_char)
        @fourth_rotor_backward_result += ALPHABET[new_index]
      end
      puts "method: fourth_rotor_backward | Fourth rotor back output: " + @fourth_rotor_backward_result
      third_rotor_backward(@fourth_rotor_backward_result)
    else
      third_rotor_backward(reflected_output)
    end
  end

  def third_rotor_backward(fourth_rotor_backward_result)
    if @third_rotor
      @third_rotor_backward_result = ""
      fourth_rotor_backward_result.each_char do |character|
        char_index = ALPHABET.index(character)
        char_index = char_index + @fourth_rotor_step_count if @fourth_rotor
        back_char = @third_rotor[char_index]
        new_index = ALPHABET.index(back_char)
        @third_rotor_backward_result += ALPHABET[new_index]
      end
      puts "method: third_rotor_backward | Third rotor back output: " + @third_rotor_backward_result
      second_rotor_backward(@third_rotor_backward_result)
    else
      second_rotor_backward(fourth_rotor_backward_result)
    end
  end

  def second_rotor_backward(third_rotor_backward_result)
    if @second_rotor
      @second_rotor_backward_result = ""
      third_rotor_backward_result.each_char do |character|
        char_index = ALPHABET.index(character)
        char_index = char_index + @third_rotor_step_count
        back_char = @second_rotor[char_index]
        new_index = ALPHABET.index(back_char)
        @second_rotor_backward_result += ALPHABET[new_index]
      end
      puts "method: second_rotor_backward | Second rotor back output: " + @second_rotor_backward_result
      first_rotor_backward(@second_rotor_backward_result)
    else
      first_rotor_backward(third_rotor_backward_result)
    end
  end

  def first_rotor_backward(second_rotor_backward_result)
    if @first_rotor
      @first_rotor_backward_result = ""
      second_rotor_backward_result.each_char do |character|
        char_index = ALPHABET.index(character)
        char_index = char_index + @second_rotor_step_count
        back_char = @first_rotor[char_index]
        new_index = ALPHABET.index(back_char)
        @first_rotor_backward_result += ALPHABET[new_index]
      end
      puts "method: first_rotor_backward | First rotor back output: " + @first_rotor_backward_result
      static_rotor_backward(@first_rotor_backward_result)
    else
      static_rotor_backward(@first_rotor_backward_result)
    end
  end

  def static_rotor_backward(first_rotor_backward_result)
    @static_rotor_backward_result = ""
    first_rotor_backward_result.each_char do |character|
      back_index = ALPHABET.index(character)
      back_index = back_index + @first_rotor_step_count
      @static_rotor_backward_result += ALPHABET[back_index]
    end
    plugboard_out(@plugboard_settings, @static_rotor_backward_result)
  end

  def plugboard_out(plugboard_settings, first_rotor_backward_result)
    @plugboard_out_result = first_rotor_backward_result
    plugboard_settings.each do |plug|
      @plugboard_out_result = @plugboard_out_result.gsub(plug[1], plug[0])
    end
    @plugboard_out_result = @plugboard_out_result.gsub(/(.{5})(?=.)/, '\1 \2')
    puts "method: plugboard_out | Plugboard backward output: " + @plugboard_out_result
  end

end