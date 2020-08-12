class Game
  def initialize
    @board = Board.new
  end

  def choose_move(piece)
    puts 'Choose your move!'
    row = get_move('Row')
    col = get_move('Column')
    if @board.check_valid_move(row, col)
      @board.save_move(piece, row, col)
    else
      puts 'INVALID MOVE'
      choose_move(piece)
    end
  end

  def turn(piece_a, piece_b)
    @board.display_board
    choose_move(piece_a)
    if @board.check_winner(piece_a)
      @board.display_board
      puts "#{piece_a} Wins!"
      return
    end
    if @board.check_tie
      @board.display_board
      puts 'TIE'
      return
    end
    turn(piece_b, piece_a)
  end

  def get_move(position)
    puts "#{position} 0, 1, or 2?"
    gets.chomp.to_i
  end
end

class Board
  def initialize
    @board = Array.new(3) { Array.new(3) { ' ' } }
  end

  def check_tie
    @board.flatten.none?(' ')
  end

  def check_valid_move(row, col)
    return false unless row.between?(0, 2)
    return false unless col.between?(0, 2)
    return false if @board[row][col] != ' '

    true
  end

  def save_move(piece, row, col)
    @board[row][col] = piece
  end

  def check_winner(piece)
    return true if check_diags(piece)

    3.times do |index|
      return true if check_lines(index, piece)
    end
    false
  end

  def check_lines(index, piece)
    return true if @board[index].all?(piece)
    return true if [@board[0][index], @board[1][index], @board[2][index]].all?(piece)
  end

  def check_diags(piece)
    puts "#{piece} wins!" if [@board[0][0], @board[1][1], @board[2][2]].all?(piece)
    puts "#{piece} wins!" if [@board[2][0], @board[1][1], @board[0][2]].all?(piece)
  end

  def display_board
    puts
    puts
    @board.each_with_index do |row, index|
      puts row.join(' | ')
      puts '---------' unless index == 2
    end
    puts
    puts
  end
end
new_game = Game.new
new_game.turn('X', '0')
