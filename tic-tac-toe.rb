class Game
    def initialize(player_one, player_two)
        @board = Board.new
        @players = {
            0 => Player.new(player_one, 'x'),
            1 => Player.new(player_two, 'o')
        }
    end

    def turn(player_id)
        @board.display_board
        puts "Choose your move!"
        puts "Row 0, 1, or 2?"
        row = gets.chomp.to_i
        puts "Column 0, 1, or 2?"
        col = gets.chomp.to_i
        @board.check_valid_move(row, col)
    end

end

class Board
    def initialize
        @board = Array.new(3) {Array.new(3)}
    end

    def check_valid_move(row, col)
        @board[row][col] == nil ? true : false
    end

    def display_board
        p @board
    end
end

class Player
    def initialize(name, piece)
        @name = name
        @piece = piece
    end
end


def play
    game = Game.new("Seamus", "Anna")
    game.turn(1)
end

play()

