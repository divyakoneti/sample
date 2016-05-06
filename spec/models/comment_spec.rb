require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "comment belongs to post" do
  	 b=Comment.reflect_on_association(:post)
  	 b.macro.should == :belongs_to
  end
  it "valid description" do
  comment=Comment.create(post_id: 1,description: 'hello')
  	expect(comment).to be_valid
  end	
  	
end
