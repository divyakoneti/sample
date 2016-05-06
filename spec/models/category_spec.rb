require 'rails_helper'

RSpec.describe Category, type: :model do
 
it " valid" do
		category=Category.create(name: 'film')  #success case
		expect(category).to be_valid
	end	
	it "category has many posts" do
  	 b=Category.reflect_on_association(:posts)
  	 expect(b.macro). to eq(:has_many)
    end
    it "valid with different category name " do
      Category.create(name: 'jokes')
     category2=Category.new(name: 'jokesbook')            #faild case
     category2.save
     category2.valid?
  	 expect(category2.errors[:email]).not_to include("already have")
    end 
    it "invalid with same category name " do
     Category.new(name: 'jokes')
     category2=Category.new(name: 'jokes')           #success case
     category2.save
     category2.valid?
  	 expect(category2.errors[:email]).to include("already have")
    end 
    

  
end
