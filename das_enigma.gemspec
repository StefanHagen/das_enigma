Gem::Specification.new do |s|
  s.name        = "das_enigma"
  s.version     = "0.0.3"
  s.date        = "2015-01-28"
  s.summary     = "Das Enigma lets you encrypt and decrypt text files using an accurate, simulated Enigma machine."
  s.description = "NOTE: This version is not yet usable, version 1.0.0 will be the first official release. Keep a look out!"
  s.authors     = ["Stefan Hagen"]
  s.email       = "stefan@stefanhagen.nl"
  s.files       = `git ls-files`.split("\n")
  s.executables << 'das_enigma'
  s.homepage    = "https://github.com/StefanHagen/das_enigma"
  s.license     = "Creative Commons Attribution-NonCommercial"
end