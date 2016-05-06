require 'rails_helper'

RSpec.describe Post, type: :model do
  it " valid title" do
  	post=Post.create(title: 'filmtile',category_id: 1,description: 'hello')
  	expect(post).to be_valid
  end
 
  #it "post has many comments" do
  	 #b=Post.reflect_on_association(:comments)
  	 #expect(b.macro).to eq(:has_many)
  #end
  it " post belongs to category" do
     b=Post.reflect_on_association(:category)
     expect(b.macro).to eq(:belongs_to)
  end
  it "post has many comments" do
   post=Post.create!(title: 'good book',description:'good')
   comment=post.comments.create(description: 'good comment',post_id: post.id)
   expect(post.comments.count).to eq(1)
  end 
  #it "post belongs to category" do
    #category=Category.create(name: 'jokes')
    #post=Post.create!(title: 'book',description: 'good',category_id: category.id)
    #expect(post).to eq(category)
  #end  

  
  #it " valid title" do
  	#post=Post.create(title: nil ,category_id: 1,description: 'hello')
  	#expect(post).to be_valid
  #end


end
