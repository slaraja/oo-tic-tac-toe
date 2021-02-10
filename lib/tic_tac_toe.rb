require 'pry'

class TicTacToe

    WIN_COMBINATIONS = [
        [0,1,2], 
        [3,4,5], 
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

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

    def input_to_index(input)
      index = input.to_i - 1
    end 

    def move(index, token = "X")
      @board[index] = token
    end

    def position_taken?(index)
      if @board[index] == "X" || @board[index] == "O"
        true
      else
        false
      end
    end

    def valid_move?(index)
      if index >= 0 && index < 9 && @board[index] == " "
        true 
      else
        false
      end
    end

    def turn
      puts "Pick a space between 1-9"
      input = gets.strip
      index = input_to_index(input)
      if valid_move?(index)
        token = current_player
        move(index, token)
      else
        turn
      end
      display_board
    end

    def won?
      WIN_COMBINATIONS.any? do |combo|
        if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
          return combo
        end 
      end 
    end
  
    def full?
      !@board.any? do |square| 
        square == " " 
      end
    end

    def draw?
      full? && !won?
    end 
    
    def over?
      won? || draw?
    end

    def winner 
      if won?
        @board[won?[0]]
      end
    end

  def play 
    if over?
      puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    else
      turn
      play
    end 
end 

end
