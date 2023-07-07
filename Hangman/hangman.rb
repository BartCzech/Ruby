require 'yaml'

class Password
  attr_accessor :hash, :word, :count

  def initialize(word)
    @word = word.split('')
    @hash = Array.new(word.length, '_') #array of length n, filled with values k
    @used_letters = []
    @count = 1
  end

  def change_hash(letter)
    did_you_find = 0
    @word.each_with_index do |element, index|
      if element == letter
        @hash[index] = letter
        did_you_find = 1
      end
    end
    if did_you_find == 0
      puts "Wrong guess!\n\n"
      @count += 1
    else
      puts "Correct guess!\n\n"
    end
  end

  def show_hash()
    for element in @hash
      print element
      print ' '
    end
    puts ''
  end
  
  def show_word()
    print @word.join()
  end

  #serialization shit
  def save_game()
    data = {word: @word, hash: @hash, count: @count}
    file = File.open('savegame.yml', 'w')
    file.puts YAML.dump(data)
    file.close
  end

  def load_game()
    data = YAML.load(File.open('savegame.yml'))
    @word = data[:word]
    @hash = data[:hash]
    @count = data[:count]
  end
end

def pick_random_word(words)
  picked = words[rand(words.length - 1)]
  return picked
end

def guess_letter(word)
  puts "Choose a letter, sir."
  letter = gets.chomp
end

def game()
  puts `clear` #very nice clears the whole terminal, notice the backticks
  words = []
  File.readlines('/home/bart/Desktop/Ruby/Odin_projects/Hangman/words.txt').each do |line|
    words << line.chomp
  end
  word = pick_random_word(words)
  #pp word
  puts 'Good day, sir! You are about to play hangman. Would you like to load last game (type 1 and press Enter), or would you like to start a new game (type 2)?'
  choice = gets.chomp.downcase
  if choice == '1'
    password = Password.new('none')
    password.load_game()
    pp password.word
  else
    puts 'Very well! Our AI chose a very nice word for you to guess.'
    puts 'You have 12 chances to guess a letter.'
    puts 'Each time your guess is wrong, the count is decreased by 1.'
    puts 'If you won\'t guess the word after all those chances, you will be hung by your balls.'
    puts 'Your word consists of ' + word.length.to_s + ' letters.'
    puts 'Good luck!'
    puts "\n"
    puts 'Guess No. 1. You have 12 chances left.'
  
    password = Password.new(word)
  end
  count = password.count  
  while count <= 12
    password.show_hash()
    password.change_hash(guess_letter(word)) 
    count = password.count
    if password.hash == password.word 
      puts 'Congratulations! You won!'
      break
    end
    if count  != 13
      puts 'You have ' + (13 - count).to_s + ' chances left.'
    elsif count == 13 && password.hash != password.word
      print 'Oopsie. You lost :) The word was: '
      password.show_word()
      puts "\nPrepare yourself to be hung!"
    end

    password.save_game()
  end
end

game()