json.array!(@posts) do |post|
  json.extract! category.posts, :id, :title,:description
end