json.content "total categories"
json.array!(@categories) do |category|
  json.extract! category, :id, :name

end
