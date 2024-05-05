genres_names = ['電化製品', '食べ物', '家具', 'ことわざ', '動物', 'ファッション', '場所']


genres_names.each do |genre|
  Genre.find_or_create_by(name: genre)
end