json.extract! puzzle, :id, :puzzle_name, :word_list, :created_at, :updated_at
json.url puzzle_url(puzzle, format: :json)
