require 'yaml'
data = YAML.load(File.open('savegame.yml'))
word = data[:word]
pp word