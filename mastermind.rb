class Board 
  def initialize(name)
    @name = name
  end

  def show_name()
    puts @name
  end
end

class ComputerGeneratedSequence
  @@values = ['white', 'black', 'red', 'green', 'blue', 'yellow', 'empty']

  attr_accessor :chosen_colors

  def initialize()
    @chosen_colors = []
    for i in 0..3
      @chosen_colors[i] = @@values.sample()
    end
    #pp @chosen_colors
  end
end

class PlayerSequence
  @@count = 1

  attr_accessor :player_chosen_colors

  def initialize()
    puts "This is your guess number #{@@count}."
    print "Choose the 1st color: "
    @first = gets.chomp
    print "Choose the 2nd color: "
    @second = gets.chomp
    print "Choose the 3rd color: "
    @third = gets.chomp
    print "Choose the 4th color: "
    @fourth = gets.chomp
    @player_chosen_colors = [@first, @second, @third, @fourth]
    @@count += 1
  end
end

def check_if_matches(sequence_, player_choice_)
  puts "\n"
  game_end = did_they_guess(sequence_, player_choice_)
  for i in 0..3
    if sequence_.include?(player_choice_[i])
      puts "Code includes #{player_choice_[i]}!"
      if sequence_[i] == player_choice_[i]
        puts "It was even guessed in the right place!"
        puts "\n"
      else 
        puts "But it is in another place.\n"
        puts "\n"
      end
    else
      puts "Code doesn't include #{player_choice_[i]}."
      puts "\n"
    end
  end
  return game_end
end

def did_they_guess(computer_seq, player_seq)
  if computer_seq == player_seq
    return 'yes'
  else 
    return 'no'
  end
end

def game()
  sequence = ComputerGeneratedSequence.new()
  puts "\n"
  puts "MASTERMIND"
  puts "\n"
  puts "The computer just generated a crazy sequence consisting of four choices."
  puts "It could have been chosen among 5 different colors:"
  puts "red, blue, green, white, black and yellow."
  puts "The AI could have also chosen to leave the place empty."
  puts "It's time for you to guess the sequence. Good luck!"
  game_end = 'no'
  while(game_end == 'no')
    player_colors = PlayerSequence.new()
    game_end = check_if_matches(sequence.chosen_colors, player_colors.player_chosen_colors)
  end
  puts "Congratulations! We're all gonna make it brahs ;D"
end

game()