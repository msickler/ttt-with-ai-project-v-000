class Game
  attr_accessor :board, :player_1, :player_2
  WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
  ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @board = board
    @player_1 = player_1
    @player_2 = player_2
  end

  def current_player
   @board.turn_count % 2 == 0 ? player_1 : player_2
  end

  def won?
  WIN_COMBINATIONS.each do |combo|
    if @board.cells[combo[0]] == "X" && @board.cells[combo[1]] == "X" && @board.cells[combo[2]] == "X"
      return combo
    elsif @board.cells[combo[0]] == "O" && @board.cells[combo[1]] == "O" && @board.cells[combo[2]] == "O"
      return combo
    end
     end
      false
    end

 def draw?
  !won? && @board.full?
  end

  def over?
  won? || draw?
  end

  def winner
    if won? && @board.cells[won?[0]] == "X"
      "X"
    elsif won? && @board.cells[won?[0]] == "O"
      "O"
    else nil
    end
  end

  def turn
    player = current_player.move(board)
    if board.valid_move?(player)
      board.update(player, current_player)
      board.display
    else
      puts "Please enter 1-9:"
      turn
    end
  end

  def play
    until over?
      turn
    end
    if draw?
      puts "Cat's Game!"
    else won?
      puts "Congratulations #{winner}!"

    end


  end





end
