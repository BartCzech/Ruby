def print_dashes()
  puts "-------------"
end

$signs = [[], [], []]
for i in 0..2
  for j in 0..2
    $signs[i][j] = '   '
  end
end

def create_board()
  print_dashes()
  puts '|' + $signs[0][0] + '|' + $signs[0][1] + '|' + $signs[0][2] + '|' 
  print_dashes()
  puts '|' + $signs[1][0] + '|' + $signs[1][1] + '|' + $signs[1][2] + '|' 
  print_dashes()
  puts '|' + $signs[2][0] + '|' + $signs[2][1] + '|' + $signs[2][2] + '|' 
  print_dashes()
end

def move(x_or_o)
  player_sign = x_or_o
  puts "Player #{player_sign} makes a move!"
  print("Select the row (1, 2 or 3): ")
  row = gets.to_i - 1
  print("Select the column (1, 2 or 3): ")
  column = gets.to_i - 1
  if row > 2 || row < 0 || column > 2 || column < 0
    puts "Dang! You put a wrong number! (or something.) Try again ;)"
    move(player_sign)
  elsif $signs[row][column] != '   '
    puts "Bruv. This place is olredy okkupied. Try again!"
    move(player_sign)
  else
    $signs[row][column] = player_sign
    create_board()
  end
end

def AI_move()
  sleep(1)
  i = rand(3)
  j = rand(3)  
  if $signs[i][j] == '   '
    $signs[i][j] = ' O '
    puts "AI move:"
    sleep(1)
    create_board()
  else 
    AI_move()
  end
end

def check_winner()
  end_already = 'no'
  draw_condition = "yes"
  for i in 0..2
    for j in 0..2
      if $signs[i][j] == '   '
        draw_condition = 'no'
      end
    end
  end
  if $signs[0][0] == ' X ' &&  $signs[0][1] == ' X ' && $signs[0][2] == ' X ' ||
  $signs[1][0] == ' X ' &&  $signs[1][1] == ' X ' && $signs[1][2] == ' X ' ||
  $signs[2][0] == ' X ' &&  $signs[2][1] == ' X ' && $signs[2][2] == ' X ' ||
  $signs[0][0] == ' X ' &&  $signs[1][0] == ' X ' && $signs[2][0] == ' X ' ||
  $signs[0][1] == ' X ' &&  $signs[1][1] == ' X ' && $signs[2][1] == ' X ' ||
  $signs[0][2] == ' X ' &&  $signs[1][2] == ' X ' && $signs[2][2] == ' X ' ||
  $signs[0][0] == ' X ' &&  $signs[1][1] == ' X ' && $signs[2][2] == ' X ' ||
  $signs[0][2] == ' X ' &&  $signs[1][1] == ' X ' && $signs[2][0] == ' X '
    puts "Whoo-hoo player X won!"
    end_already = 'yes'
  elsif $signs[0][0] == ' O ' &&  $signs[0][1] == ' O ' && $signs[0][2] == ' O ' ||
  $signs[1][0] == ' O ' &&  $signs[1][1] == ' O ' && $signs[1][2] == ' O ' ||
  $signs[2][0] == ' O ' &&  $signs[2][1] == ' O ' && $signs[2][2] == ' O ' ||
  $signs[0][0] == ' O ' &&  $signs[1][0] == ' O ' && $signs[2][0] == ' O ' ||
  $signs[0][1] == ' O ' &&  $signs[1][1] == ' O ' && $signs[2][1] == ' O ' ||
  $signs[0][2] == ' O ' &&  $signs[1][2] == ' O ' && $signs[2][2] == ' O ' ||
  $signs[0][0] == ' O ' &&  $signs[1][1] == ' O ' && $signs[2][2] == ' O ' ||
  $signs[0][2] == ' O ' &&  $signs[1][1] == ' O ' && $signs[2][0] == ' O '
    puts "Whoo-hoo player O won!"
    end_already = 'yes'
  elsif draw_condition == 'yes'
    puts "DRAAAWWW!!!"
    end_already = 'yes'
  end
  return end_already
end

def game() 
  create_board()
  puts "Welcome, sir. Would you like to play against another human being or against our AI?"
  print "Press 1 - human, press 2 - AI: "
  choice = gets.to_i
  end_condition = 'no'

  if choice == 1
    while(end_condition == 'no')
      move(' X ')
      end_condition = check_winner()
      if end_condition != 'yes'
        move(' O ')
        end_condition = check_winner()
      end
    end
  elsif choice == 2
    while(end_condition == 'no')
      move(' X ')
      end_condition = check_winner()
      if end_condition != 'yes'
        AI_move()
        end_condition = check_winner()
      end
    end
  else 
    puts "Wrong input. Closing the game. ;)"
  end
end

game()