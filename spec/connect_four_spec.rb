require 'connect_four'

describe 'ConnectFour' do
  let(:game) {ConnectFourMethods.new}

  before(:each) do
  	@board = game.create_board
  	@player1 = double
  	@player2 = double
  	allow(@player1).to receive(:symbol).and_return("r")
  	allow(@player2).to receive(:symbol).and_return("b")
  	allow(@player1).to receive(:name).and_return("player1")
  	allow(@player2).to receive(:name).and_return("player2")
  end

  describe '#create_board' do
  	it 'creates a new, blank board' do
  	  expect(game.create_board).to eql([["o", "o", "o", "o", "o", "o"], 
  	  									["o", "o", "o", "o", "o", "o"], 
  	  									["o", "o", "o", "o", "o", "o"], 
  	  									["o", "o", "o", "o", "o", "o"], 
  	  									["o", "o", "o", "o", "o", "o"], 
  	  									["o", "o", "o", "o", "o", "o"], 
  	  									["o", "o", "o", "o", "o", "o"]])
  	end
  end

  describe '#print_board' do
  	it "prints the instance variable board" do
  	  @board = game.create_board
  	  expect(game.print_board(@board)).to eql("1\s\s2\s\s3\s\s4\s\s5\s\s6\s\s7\no\s\so\s\so\s\so\s\so\s\so\s\so\s\s\no\s\so\s\so\s\so\s\so\s\so\s\so\s\s\no\s\so\s\so\s\so\s\so\s\so\s\so\s\s\no\s\so\s\so\s\so\s\so\s\so\s\so\s\s\no\s\so\s\so\s\so\s\so\s\so\s\so\s\s\no\s\so\s\so\s\so\s\so\s\so\s\so\s\s\n")
  	end
  end

  describe '#introduction' do
  	it "prints the introduction to the game" do
  	  expect(game.introduction).to be_a(String)
  	end
  end

  describe '#place_piece' do

  	context "given an empty board" do
  	  it "places a game piece in the lowest part of the board possible" do
  	  	expect(game.place_piece(@board,1,@player1.symbol)).to eql([["o", "o", "o", "o", "o", "r"], 
  	  											 		   		   ["o", "o", "o", "o", "o", "o"], 
  	  													   		   ["o", "o", "o", "o", "o", "o"], 
  	  													   		   ["o", "o", "o", "o", "o", "o"], 
  	  													   		   ["o", "o", "o", "o", "o", "o"], 
  	  													   		   ["o", "o", "o", "o", "o", "o"], 
  	  													   		   ["o", "o", "o", "o", "o", "o"]]) 
  	  end
  	end

  	context "given a board with some pieces in it" do
  	  it "places a piece in the lowest part possible with the right piece" do
  	  	@board = [["o", "o", "b", "r", "r", "r"], 
  	  			  ["o", "o", "r", "b", "b", "b"], 
  	  			  ["o", "o", "o", "o", "b", "b"], 
  	  		      ["o", "o", "o", "o", "o", "r"], 
 			      ["o", "o", "o", "o", "o", "b"], 
  	  		      ["o", "o", "o", "o", "o", "b"], 
  	  		      ["o", "o", "o", "o", "o", "r"]]
  	  	expect(game.place_piece(@board,4,@player2.symbol)).to eql([["o", "o", "b", "r", "r", "r"], 
  	  			  								  		 		   ["o", "o", "r", "b", "b", "b"], 
  	  			  								 		   		   ["o", "o", "o", "o", "b", "b"], 
  	  		      								 		   		   ["o", "o", "o", "o", "b", "r"], 
 			      								 		   		   ["o", "o", "o", "o", "o", "b"], 
  	  		     								  		   		   ["o", "o", "o", "o", "o", "b"], 
  	  		      								  		   		   ["o", "o", "o", "o", "o", "r"]])
  	  end
  	end

  	context "when trying to place a piece in a full column" do
  	  it "fails and asks the player to choose a different column" do
  	  	@board = [["b", "r", "b", "r", "r", "r"], 
  	  			  ["o", "o", "r", "b", "b", "b"], 
  	  			  ["o", "o", "o", "o", "b", "b"], 
  	  		      ["o", "o", "o", "o", "o", "r"], 
 			      ["o", "o", "o", "o", "o", "b"], 
  	  		      ["o", "o", "o", "o", "o", "b"], 
  	  		      ["o", "o", "o", "o", "o", "r"]]
  	    expect(game.place_piece(@board,1,@player2.symbol)).to eql(false)
  	  end
  	end
  end

  describe "#four_in_a_row?" do
  	context "given an array without four of the same in a row" do
  	  it "returns false" do
  	  	array = ["o","o","r","o","b","b","r"]
  	  	expect(game.four_in_a_row?(array)).to eql(false)
  	  end
  	end

  	context "given an array with four of the same in a row" do
  	  it "returns the symbol" do
  	  	array = ["r","o","b","b","b","b","r"]
  	  	expect(game.four_in_a_row?(array)).to eql("b")
  	  end
    end
  end

  describe "#check_vertical" do

  	context "given an empty board" do
  	  it "returns false" do
  	  	@board = game.create_board
  	  	expect(game.check_vertical(@board)).to eql(false)
  	  end
  	end

  	context "given a board with 4 pieces in a row horizontally" do
  	  it "returns the symbol that won" do
  	    @board = [["o", "o", "b", "r", "r", "r"], 
  	  			  ["o", "o", "r", "b", "b", "b"], 
  	  			  ["o", "o", "o", "o", "b", "b"], 
  	  		      ["o", "o", "o", "o", "o", "r"], 
 			      ["o", "o", "r", "r", "r", "r"], 
  	  		      ["o", "o", "o", "o", "o", "b"], 
  	  		      ["o", "o", "o", "o", "o", "r"]]
  	    expect(game.check_vertical(@board)).to eql(@player1.symbol)
  	  end
  	end
  end

  describe "#check_horizontal" do

  	context "given a non winning board" do
  	  it "returns false" do
  	  	@board = [["o", "o", "b", "r", "r", "r"], 
  	  			  ["o", "o", "r", "b", "b", "b"], 
  	  			  ["o", "o", "o", "o", "b", "b"], 
  	  		      ["o", "o", "o", "o", "o", "r"], 
 			      ["o", "o", "b", "r", "r", "r"], 
  	  		      ["o", "o", "o", "o", "o", "b"], 
  	  		      ["o", "o", "o", "o", "o", "r"]]
  	    expect(game.check_horizontal(@board)).to eql(false)
  	  end
  	end

  	context "given a winning board" do
  	  it "returns the symbol that won" do
  	  	@board = [["o", "o", "b", "r", "r", "r"], 
  	  			  ["o", "o", "r", "b", "b", "b"], 
  	  			  ["o", "o", "o", "b", "b", "b"], 
  	  		      ["o", "o", "o", "b", "o", "r"], 
 			      ["o", "o", "r", "b", "r", "r"], 
  	  		      ["o", "o", "o", "o", "o", "b"], 
  	  		      ["o", "o", "o", "o", "o", "r"]]
  	    expect(game.check_horizontal(@board)).to eql(@player2.symbol)
  	  end
  	end
  end

  describe "#check_diagonal" do

  	context "given a non winning board" do
  	  it "returns false" do
  	  	@board = [["o", "o", "b", "r", "r", "r"], 
  	  			  ["o", "o", "r", "b", "b", "b"], 
  	  			  ["o", "o", "o", "o", "b", "b"], 
  	  		      ["o", "o", "o", "o", "o", "r"], 
 			      ["o", "o", "b", "r", "r", "r"], 
  	  		      ["o", "o", "o", "o", "o", "b"], 
  	  		      ["o", "o", "o", "o", "o", "r"]]
  	    expect(game.check_diagonal(@board)).to eql(false)
  	  end
  	end

  	context "given a winning board" do
  	  it "returns the symbol of the winning player" do
  	  	@board = [["o", "o", "b", "r", "r", "b"], 
  	  			  ["o", "o", "r", "b", "b", "b"], 
  	  			  ["o", "o", "r", "b", "b", "b"], 
  	  		      ["o", "o", "b", "r", "b", "r"], 
 			      ["o", "o", "b", "r", "r", "r"], 
  	  		      ["o", "o", "o", "o", "r", "b"], 
  	  		      ["o", "o", "o", "o", "o", "b"]]
  	    expect(game.check_diagonal(@board)).to eql(@player2.symbol)
  	  end
  	end
  end

  describe "#check_reverse_diagonal" do
    context "given a non-winning board" do
      it "returns false" do
  	  	@board = [["o", "o", "b", "r", "r", "r"], 
  	  			  ["o", "o", "r", "b", "b", "b"], 
  	  			  ["o", "o", "o", "o", "b", "b"], 
  	  		      ["o", "o", "o", "o", "o", "r"], 
 			      ["o", "o", "b", "r", "r", "r"], 
  	  		      ["o", "o", "o", "o", "o", "b"], 
  	  		      ["o", "o", "o", "o", "o", "r"]]
  	    expect(game.check_reverse_diagonal(@board)).to eql(false)
  	  end
  	end

  	context "given a winning board" do
  	  it "returns the symbol of the winning player" do
  	  	@board = [["o", "o", "b", "r", "r", "b"], 
  	  			  ["o", "o", "r", "b", "r", "b"], 
  	  			  ["o", "o", "r", "b", "b", "b"], 
  	  		      ["o", "r", "b", "r", "b", "r"], 
 			      ["o", "o", "r", "r", "r", "r"], 
  	  		      ["o", "o", "o", "r", "r", "b"], 
  	  		      ["o", "o", "o", "o", "r", "b"]]
  	  	expect(game.check_reverse_diagonal(@board)).to eql(@player1.symbol)
  	  end
  	end
  end
end