class Game
  def initialize
    @board = Board.new
  end

  def choose_move(piece)
    @board.display_board
    puts 'Choose your move!'
    puts 'Row 0, 1, or 2?'
    row = gets.chomp.to_i
    puts 'Column 0, 1, or 2?'
    col = gets.chomp.to_i
    if @board.check_valid_move(row, col)
      @board.save_move(piece, row, col)
    else
      puts 'INVALID MOVE'
      choose_move(piece)
    end
  end
end

class Board
  def initialize
    @board = Array.new(3) { Array.new(3) { ' ' } }
  end

  def check_valid_move(row, col)
    return false unless row.between?(0, 2)
    return false unless col.between?(0, 2)
    return false if @board[row][col] != ' '

    true
  end

  def save_move(piece, row, col)
    @board[row][col] = piece
    check_winner
  end

  def check_winner
    check_diags
    3.times do |index|
      check_row(index)
      check_col(index)
    end
  end

  def check_row(index)
    puts 'X wins!' if @board[index].all?('X')
    puts '0 wins!' if @board[index].all?('0')
  end

  def check_col(index)
    puts 'X wins!' if [@board[0][index], @board[1][index], @board[2][index]].all?('X') # check cols
    puts '0 wins!' if [@board[0][index], @board[1][index], @board[2][index]].all?('0')
  end

  def check_diags
    puts 'X wins!' if [@board[0][0], @board[1][1], @board[2][2]].all?('X')
    puts 'X wins!' if [@board[2][0], @board[1][1], @board[0][2]].all?('X')
    puts 'Y wins!' if [@board[0][0], @board[1][1], @board[2][2]].all?('Y')
    puts 'Y wins!' if [@board[2][0], @board[1][1], @board[0][2]].all?('Y')
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
loop { new_game.choose_move('X') }
