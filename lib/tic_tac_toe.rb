class TicTacToe
    attr_accessor :board

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [2,4,6],
        [0,4,8]

    ]

    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    def display_board
        puts (" #{@board[0]} | #{@board[1]} | #{@board[2]} \n")
        puts ("-----------\n")
        puts (" #{@board[3]} | #{@board[4]} | #{@board[5]} \n")
        puts (" ----------- \n")
        puts (" #{@board[6]} | #{@board[7]} | #{@board[8]} ")
    end

    def input_to_index(index)
        index = index.to_i
        index -= 1
    end

    def move(index, token = "X")
        @board[index] = token
    end

    def position_taken?(index)
        position_taken = @board[index] == " " ? false : true
        position_taken
    end

    def valid_move?(position)
        if (position >= 0 && position <= @board.length && position_taken?(position) == false)
            true
        else
            false
        end
    end

    def turn_count
        marked_spaces = @board.filter { | marks | marks != " " }
        marked_spaces.count
    end

    def current_player
        if (turn_count == 0 || turn_count.even?)
            "X"
        elsif (turn_count.odd?)
            "O"
        end
    end

    def turn
        position = gets.chomp
        position = input_to_index(position)
        if valid_move?(position)
            move(position, current_player())
            self.display_board
        else
            turn
        end
    end

    def won?
        winning_combinations = WIN_COMBINATIONS.find_all do | combo |
            if @board[combo[0]] == @board[combo[1]] && @board[combo[0]] == @board[combo[2]] && @board[combo[0]] != " "
                return [combo[0], combo[1], combo[2]]
            end
        end
        result = winning_combinations.length > 0 ? winning_combinations : false
    end

    def full?
        @board.all? { |token| token != " " }
    end

    def draw?
        if self.won? == false && self.full?
            true
        else 
            false
        end
    end

    def over?
        if self.draw? || self.won? then true end
    end

    def winner
        if self.won?
            winning_combo = self.won?
            winning_token = @board[winning_combo[0]]
        end
    end

    def play
        until self.over? do
            self.turn
        end
        if won? 
            puts "Congratulations #{self.winner}!"
        else
            puts "Cat's Game!"
        end
    end
end

game = TicTacToe.new
game.play