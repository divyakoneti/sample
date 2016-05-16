json.extract! @category,:created_at
json.edit_url edit_category_url(@category) 
json.message "created successfully"
json.posts @category.posts,:id,:title
