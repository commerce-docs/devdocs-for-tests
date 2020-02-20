# frozen_string_literal: true

# Read the Docfile file
module Docfile

  def self.read
    YAML.load_file('Docfile.yml')
  end
end
