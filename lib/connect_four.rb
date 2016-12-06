class ConnectFourMethods

  def create_board
  	board = []
  	7.times do
  	  column = []
  	  6.times do
  	  	column << "o"
  	  end
  	  board << column
  	end
  	board
  end

  def print_board(board)
  	string = ""
  	for i in 0..5
  	  for j in 0..6
  	    string << board[j][i] + "\s\s"
  	  end
  	  string << "\n"
  	end
  	string = "1\s\s2\s\s3\s\s4\s\s5\s\s6\s\s7\n" + string
  end

  def introduction
  	"Hello. Welcome to Connect Four. The goal of this game is to 
  	 connect four of your pieces in a column, row, or diagonal. You 
  	 may only place a piece in a column, in which the piece will fall
  	 as far as possible. The first player to connect 4 pieces together
  	 will win."
  end

  def place_piece(board,num,symbol)
  	index = board[num-1].find_index {|i| i != "o"}
  	if index == 0
  	  false
  	elsif index == nil
  	  index = board[num-1].length - 1
  	  board[num-1][index] = symbol
  	  board
  	else
  	  index -= 1
  	  board[num-1][index] = symbol
  	  board
  	end
  end

  def four_in_a_row?(row)
  	counter = 0
  	symbol = ""
  	row.each do |item|
  	  if item == "o"
  	  	counter = 0
  	  	symbol = ""
  	  elsif item == symbol  	  	
		counter += 1
  	  	if counter == 4
  	  	  return symbol
  	  	end
  	  else
  	  	counter = 1
  	  	symbol = item
  	  end
  	end
  	false
  end

  def check_vertical(board)
   	board.each do |column|
  	  winner = four_in_a_row?(column)
  	  if winner
  	  	return winner
  	  end
  	end
  	false
  end

  def check_horizontal(board)
  	num = 0
  	until num == 6
  	  row = []
  	  board.each do |column|
        row << column[num]
      end
      winner = four_in_a_row?(row)
      return winner if winner
      num += 1
    end
    false
  end

  def check_diagonal(board)
    starts = [[0,3],[0,4],[0,5],[1,5],[2,5],[3,5]]
    starts.each do |spot|
      row = []
      until spot[1] < 0 || spot[0] > 6
        row << board[spot[0]][spot[1]]
        spot[0] += 1
        spot[1] -= 1
      end
      winner = four_in_a_row?(row)
      return winner if winner
    end
    false
  end

  def check_reverse_diagonal(board)
  	starts = [[6,3],[6,4],[6,5],[5,5],[4,5],[3,5]]
  	starts.each do |spot|
  	  row = []
  	  until spot[1] < 0 || spot[0] < 0
  	  	row << board[spot[0]][spot[1]]
  	  	spot[0] -= 1
  	  	spot[1] -= 1
  	  end
  	  winner = four_in_a_row?(row)
  	  return winner if winner
  	end
  	false
  end
end

class Player
  attr_accessor :name, :symbol

  def initialize(name,symbol)
  	@name = name
  	@symbol = symbol
  end
end


