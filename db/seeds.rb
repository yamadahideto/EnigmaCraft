
genres_names = ['電化製品', '食べ物', '飲み物', '家具', '場所', '動物', 'ことわざ', '四字熟語', 'ファッション', '乗り物', '自作の謎']

genres_names.each do |genre|
  Genre.find_or_create_by(name: genre)
end