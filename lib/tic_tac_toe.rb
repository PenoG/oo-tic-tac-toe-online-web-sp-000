class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end
 
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end
 
  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end
 
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
  ].freeze
  
  def input_to_index(user_input)
    user_input.to_i - 1
  end
  
  def move(index, player)
    @board[index] = player
  end
  
  def position_taken?(index)
    if @board[index] == " " or @board[index] == "" or @board[index] == nil
      false
    elsif @board[index] == "X" or @board[index] == "O"
      true
    end
  end
  def valid_move?(index)
    if index.between?(0,8) 
     if !position_taken?(index)
        true
      end
    end
  end
  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end  
  end
  def won?
    WIN_COMBINATIONS.detect do |combo|
      @board[combo[0]] == @board[combo[1]] &&
      @board[combo[1]] == @board[combo[2]] &&
      position_taken?(combo[0])
    end
  end
  
  def full?
    @board.all? {|token| token == "X" || token == "O"}
  end

  def draw?
    full? && !won?
  end

  def over?
    draw? || full? || won?
  end

  def winner
    if won?
      @board[won?.first]
    end
  end
  def play(board)
    turn(board) until over?(board)
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cat's Game!"
    end
  end
end