require_relative 'connect_four'
  
class ConnectFourPlay

  def initialize
  	menu
  end

  def menu
  	puts "1. New game\n2. Quit\nPlease enter 1 for a new @game or 2 to quit."
	input = gets.chomp.to_i
	case input
	when 1
      new_game
	when 2
	  puts "Thanks for playing!"
	else
	  puts "Invalid input."  
	  menu
	end
  end

  def new_game
  	@game = ConnectFourMethods.new
  	puts @game.introduction
  	puts "Please enter a name for player 1"
  	name = gets.chomp
  	@player1 = Player.new(name,"☀")
  	puts "Hello #{@player1.name}. Your symbol will be #{@player1.symbol}"
  	puts "Please enter a name for player 2"
  	name = gets.chomp
  	@player2 = Player.new(name,"⛰")
  	puts "Hello #{@player2.name}. Your symbol will be #{@player2.symbol}"
  	@board = @game.create_board
  	game_loop
  end

  def game_loop
  	player = @player1
  	loop do
  	  print @game.print_board(@board)
  	  puts "#{player.name} please enter a column number."
  	  column = gets.chomp.to_i
  	  move = @game.place_piece(@board,column,player.symbol)
  	  until move
  	  	puts "Invalid input. Please enter a different column number."
  	  	column = gets.chomp.to_i
  	  	move = @game.place_piece(@board,column,player.symbol)
  	  end
  	  if @game.check_vertical(@board) || @game.check_horizontal(@board) || @game.check_diagonal(@board) || @game.check_reverse_diagonal(@board)
  		break
  	  else
  	  	player == @player1 ? player = @player2 : player = @player1
  	  end
  	end
  	winner = false
  	print @game.print_board(@board)
  	until winner
      winner = @game.check_vertical(@board) unless @game.check_vertical(@board) == false
  	  winner = @game.check_horizontal(@board) unless @game.check_horizontal(@board) == false
  	  winner = @game.check_diagonal(@board) unless @game.check_diagonal(@board) == false
  	  winner = @game.check_reverse_diagonal(@board) unless @game.check_reverse_diagonal(@board) == false
  	end
  	if @player1.symbol == winner
  	  puts "#{@player1.name} wins!"
  	else
  	  puts "#{@player2.name} wins!"  
 	end
  end
end

ConnectFourPlay.new