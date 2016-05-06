require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
	let (:valid_params) {
		{description: 'this is ood book',post_id: 1}
	}
	let (:invalid_parms) {
		{description: nil,post_id:nil}
	}
    describe " GET #edit" do
    	it "assigns requested comment as @comment" do
    		
    		category=Category.create(name:"sample") 
    		post=Post.create(title: 'this is book',description: 'good book')
    		comment=post.comments.create!(valid_params)
    		get :edit,{category_id: category.id,post_id: post.id, id: comment.id }
    		expect(assigns(:comment)).to eq(comment)
    	end
    end	
    describe "PUT #update" do
        let (:new_params) {
        	{description: "this is old book",post_id: 2}
        }
        context "update date with valid params" do
           it " updated comment as @comment" do
            category=Category.create(name:"sample") 
    	    post=Post.create(title: 'this is book',description: 'good book')
    	    comment=post.comments.create!(valid_params)
    	    put :update ,{category_id: category.id ,post_id:post.id,id: comment.id,:comment => new_params }
            comment.reload
           end
           it " assigns comment as @comments" do
            category=Category.create(name:"sample") 
    	    post=Post.create(title: 'this is book',description: 'good book')
    	    comment=post.comments.create!(valid_params)
    	    put :update ,{category_id: category.id ,post_id:post.id,id: comment.id,:comment => new_params }
            expect(assigns(:comment)).to eq(comment)
           end
           it " redirect to comment as @comments index" do
            category=Category.create(name:"sample") 
    	    post=Post.create(title: 'this is book',description: 'good book')
    	    comment=post.comments.create!(valid_params)
    	    put :update ,{category_id: category.id ,post_id:post.id,id: comment.id,:comment => new_params }
            expect(response).to redirect_to category_post_comments_path
           end
        end
        context "update with invalid params" do
        	it " updated comment as @comment" do
        	 category=Category.create(name:"sample") 
    	     post=Post.create(title: 'this is book',description: 'good book')
    	     comment=post.comments.create!(valid_params)
    	     put :update ,{category_id: category.id ,post_id:post.id,id: comment.id,:comment => new_params }
             expect(assigns(:comment)).to eq(comment)
            end	
            it " re render the edit page" do
             category=Category.create(name:"sample") 
    	     post=Post.create(title: 'this is book',description: 'good book')
    	     comment=post.comments.create!(valid_params)
    	     get :update ,{category_id: category.id ,post_id:post.id,id: comment.id,:comment => invalid_parms }
             puts comment.inspect
             expect(response).to render_template("edit")
           end
        end    
    end 
    describe "DELETE  #destroy" do
        context " delete the comment" do
           it " delete the comment " do
           	category=Category.create(name:"sample") 
    	    post=Post.create(title: 'this is book',description: 'good book')
    	    comment=post.comments.create!(valid_params)
    	    expect {
	        delete :destroy, {category_id: category.id ,post_id:post.id,id: comment.id }
	        }.to change(Comment, :count).by(-1)
	       end
	       it " after deletion redirect the index page" do
	       	category=Category.create(name:"sample") 
    	    post=Post.create(title: 'this is book',description: 'good book')
    	    comment=post.comments.create!(valid_params)
    	    delete :destroy, {category_id: category.id ,post_id:post.id,id: comment.id }
    	    expect(response).to redirect_to category_post_comments_path
    	   end 
	    end
	end       


            


end
