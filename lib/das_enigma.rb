require "das_enigma/encryption"
require "das_enigma/decryption"
require "das_enigma/enigma"

class DasEnigma

  def self.help
    help_text = "Use Das Enigma to encrypt/decrypt .txt files using a simulated Enigma Machine. example: `$ das_enigma encrypt my_file.txt`."
    puts help_text
  end

end

ARGV.each do|a| 
  puts "Argument: #{a}" 
end

if ARGV[0]
  if ARGV[0] == "encrypt"
    if ARGV[1]
      Encryption.new(ARGV[1])
    else
      puts "You need to specify the path to file to be encrypted as the second option."
    end
  elsif ARGV[0] == "decrypt"
    if ARGV[1]
      Decryption.new(ARGV[1])
    else
      puts "You need to specify the path to the encrypted file as the second option."
    end
  else 
    puts "You need to pass the option 'encrypt' or 'decrypt' as the first parameter."
  end
else
  puts "You need to pass the option 'encrypt' or 'decrypt' as the first parameter."
end