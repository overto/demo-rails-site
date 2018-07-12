
class PuzzleGenerator < Prawn::Document
  attr_accessor :word_list, :grid_size
  attr_reader :answer_key, :words_not_placed, :puzzle_generated

  def initialize(puzzle_name, words, grid_size)
    super()

    @word_list = format_words_list_array(words)
    @grid_size = grid_size
    @grid = Array.new(grid_size) { Array.new(grid_size, "-") }
    @directions = [ "vert_up", "vert_up_rev", "vert_down", "vert_down_rev", "horiz_left", "horiz_left_rev", "horiz_right", "horiz_right_rev" ,"diag_left_up", "diag_left_up_rev", "diag_left_down", "diag_left_down_rev", "diag_right_up", "diag_right_up_rev", "diag_right_down", "diag_right_down_rev" ]
    @words_not_placed = Array.new
    @used_directions = Array.new
    @puzzle_generated = false
    @answer_key = nil
    @words_placed = Array.new

    if ! @word_list.nil?
      # Generate New Puzzle
      generate_puzzle

      # Create PDF
      create_pdf(puzzle_name)
    end

  end

  private

  def create_pdf(puzzle_name)

    # Prawn methods
    font "Courier", size: 24
    text puzzle_name + "\n\n", align: :center
    font "Courier", size: 10

    # Format Puzzle to PDF
    @words_placed = @word_list - @words_not_placed
    text grid, align: :center
    font "Courier", size: 14
    text "\nList of Words to Find:\n\n"
    font "Courier", size: 10
    column_box([0, cursor], reflow_margins: true, columns: 4, width: bounds.width) do
      text @words_placed.join("\n")
    end

    if ! @words_not_placed.empty?
      font "Courier", size: 14
      text "\nWords not Placed on Board:\n\n"
      font "Courier", size: 10
      column_box([0, cursor], reflow_margins: true, columns: 4, width: bounds.width) do
        text @words_not_placed.join("\n")
      end
    end

    start_new_page

    # Format Answer Key to PDF
    font "Courier", size: 20
    text "Answer Key\n\n", align: :center
    font "Courier", size: 10
    text answer_key, align: :center
    # Word list to PDF
    font "Courier", size: 14
    text "\nList of Words to Find:\n\n"
    font "Courier", size: 10
    column_box([0, cursor], reflow_margins: true, columns: 4, width: bounds.width) do
      text @words_placed.join("\n")
    end

    if ! @words_not_placed.empty?
      font "Courier", size: 14
      text "\nWords not Placed on Board:\n\n"
      font "Courier", size: 10
      column_box([0, cursor], reflow_margins: true, columns: 4, width: bounds.width) do
        text @words_not_placed.join("\n")
      end
    end

  end

  def format_words_list_array(words)
    if ! words.nil?
      word_list = words.upcase.split(/\n/)
      if ! word_list.nil?
        word_list.collect! do |word|
          word.chomp.strip.squish
        end
        return word_list.sort_by {|w| -w.length}
      end
    end
    return nil
  end

  def generate_puzzle
    # Loop through word list
    count_word = 0
    @word_list.each do |w|
      count_word += 1

      if w.length < @grid_size && w.length > 1
        word_array = w.chars.to_a
        word_placed = false
        #Renew parallel grid
        @parallel_grid = Array.new(grid_size) {Array.new(grid_size, "-")}
        # Get Random start position (must not be used - check parallel array, also cell must be blank or equal to first or last char of word)
        start_position = get_start_position(word_array)
        start_position_tries = 0
        # Loop until word placed or all available start positions tried
        while word_placed == false && start_position != nil
          start_position_tries += 1

          # Get random direction + store used random
          @used_directions.clear
          @used_directions = @directions.dup
          random_direction = get_random_direction(@used_directions)

          if random_direction != nil
            @used_directions.delete(random_direction)
          end

          tries = 0
          while random_direction != nil && word_placed == false
            tries += 1
            # Loop through directions, try place word with random direction
            word_placed = place_word(start_position, word_array, random_direction)

            if word_placed == false
              # get new random direction
              random_direction = get_random_direction(@used_directions)
              if random_direction != nil
                @used_directions.delete(random_direction)
              end
            end

          end

          @parallel_grid[start_position[0]][start_position[1]] = "*" if word_placed == false # mark as tried
          start_position = get_start_position(word_array)

        end
        # If no new start position (nil returned) Then add word to non-placed-list and go on to next word
        @words_not_placed.push(w) if word_placed == false && start_position.nil?

      else
        # Put word in non-placed words list
        @words_not_placed.push(w)
      end

    end

    @puzzle_generated = true
    @answer_key = draw_grid

  end

  def grid
    if @puzzle_generated
      # Cover blank cells with random letters contained in words in word list
      @grid.each_with_index do |row, row_index|
        row.each_with_index do |col, col_index|
          if col == "-"
            @grid[row_index][col_index] = get_letters_in_words.sample
          end
        end
      end
    else
      return nil
    end
    return draw_grid
  end

  def get_random_direction(direction_array)
    return direction_array.sample
  end

  def get_start_position(word_array)

    rows_with_available_positions = Array.new
    row_col_available_hash = Hash.new

    @parallel_grid.each_with_index do |row, row_index|
      col_with_available_positions = Array.new
      row.each_with_index do |col, col_index|
        if @grid[row_index][col_index] != word_array.first && @grid[row_index][col_index] != word_array.last && @grid[row_index][col_index] != "-"
          col = "*" # Set parallel grid cell to used if corresponding grid cell is not equal to word first or last letter and not equal to blank
        end
        if (col != "*")  # if cell not tried already
          # if cell in actual grid has letter not equal to word first (check if reverse) then mark as used !
          col_with_available_positions.push(col_index)
        end
      end
      if col_with_available_positions.count > 0
        rows_with_available_positions.push(row_index)
        row_col_available_hash[row_index] = col_with_available_positions
      end
    end

    if rows_with_available_positions.count > 0 # Check if any available positions to get rand start position from
      # Exclude unavailable cells and sample/random pick start position
      rand_row = rows_with_available_positions.sample
      rand_col = row_col_available_hash[rand_row].sample
      return [rand_row, rand_col]
    else
      return nil
    end

  end

  def place_word(start_position, word_arr, direction)
    word_array = word_arr.dup
    success = false

    if direction.include?("_up")
      if start_position[0].between?(word_array.length - 1, @grid_size - 1) == false
        return false
      end
    end

    if direction.include?("_down")
      sp_row = start_position[0]
      range_top = @grid_size - word_array.length
      if start_position[0].between?(0, @grid_size - word_array.length) == false
        return false
      end
    end

    if direction.include?("_left")
      if start_position[1].between?(word_array.length - 1, @grid_size - 1) == false
        return false
      end
    end

    if direction.include?("_right")
      if start_position[1].between?(0, @grid_size - word_array.length) == false
        return false
      end
    end

    if direction.include?("_rev")
      word_array.reverse!
    end

    row = start_position[0]
    col = start_position[1]
    placement = Array.new # Store letter positions

    word_array.each do |letter|
      if @grid[row][col] == "-" || @grid[row][col] == letter # If grid cell is blank or same as letter to be placed
        placement.push([row, col])
      end

      row -= 1 if direction.include?("_up")
      row += 1 if direction.include?("_down")
      col -= 1 if direction.include?("_left")
      col += 1 if direction.include?("_right")

    end

    if placement.length == word_array.length
      word_array.each_with_index do |letter, index|
        place_row = placement[index][0]
        place_col = placement[index][1]
        if letter == " "
          @grid[place_row][place_col] = "-"
        else
          @grid[place_row][place_col] = letter
        end
      end
      success = true
    end

    return success
  end

  def get_letters_in_words
    # get all letters of words in an array (only one of each)
    #randomly pick from this array and place these letters in blank position
    chars_in_words_arr = Array.new
    @word_list.each do |word|
      word.chars.to_a.each do |letter|
        if ("A".."Z").include?(letter.upcase)
          if chars_in_words_arr.include?(letter) != true
            chars_in_words_arr.push(letter.upcase)
          end
        end
      end
    end

    return chars_in_words_arr
  end

  def draw_grid

    if @puzzle_generated
      display = "\n"
      @grid.each do |row|
        row.each do |col|
          display += "#{col} "
        end
        display = display.strip
        display += "\n"
      end
      return display
    else
      return nil
    end

  end

end