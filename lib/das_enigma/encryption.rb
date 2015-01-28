class Encryption

  def initialize(file_path)
    file = File.open(File.expand_path(file_path), 'r')
    puts file
  end

end