# frozen_string_literal: true

# top-level namespace for the DasEnigma gem
module DasEnigma
  # require all ruby files in the lib/das_enigma folder
  Dir['./lib/das_enigma/**/*.rb'].each do |file|
    require file
  end
end
