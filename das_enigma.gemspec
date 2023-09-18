# frozen_string_literal: true

Gem::Specification.new do |spec|
  # General information
  spec.name = 'das_enigma'
  spec.version = '0.0.3'
  spec.required_ruby_version = '>= 3.0.1'
  spec.summary = 'Das Enigma lets you encrypt and decrypt text files using an accurate, simulated Enigma machine.'
  spec.description = 'NOTE: This version is not yet usable, version 1.0.0 will be the first official release.'
  spec.authors = ['Stefan Hagen']
  spec.files = `git ls-files`.split('\n')
  spec.executables << 'das_enigma'
  spec.homepage = 'https://github.com/StefanHagen/das_enigma'
  spec.license = 'Creative Commons Attribution-NonCommercial'
end
