require 'rails_helper'

RSpec.describe PostsController, type: :controller do
	let(:valid_params){
		{title:"my book",description:"Good book"}
	}
	let(:invalid_params){
		{title:nil,description:"Good",category_id:nil}
	}
	describe "GET #index" do
	    it "assigns all posts as @posts" do
	      category = Category.create(name:"sample")
	      post1=Post.create(title:"book1",description:"book1good",category_id:2)    #create posts for category
	      post2=Post.create(title:"book2",description:"book2good",category_id:2)
	      post3=Post.create(title:"book3",description:"book3good",category_id:2)
	      get :index,:category_id=>category.to_param
	      expect(assigns(:posts)).to eq([post1,post2,post3])
	    end
	end
	describe "GET #new" do 
		it "create a new category" do 
			category=Category.create(name:"sample")                #new post for category
			get :new,:category_id=>category.to_param
			expect(assigns(:post)).to be_a_new(Post)
		end
	end
	describe "POST #create" do 
		context "with valid params" do 
			it "create a new post to @post" do 
				
				expect{                                                                  
					category=Category.create(name:"sample")
					post :create,{:category_id=>category.to_param,:post=>valid_params}  #create post for category
				}.to change(Post,:count).by(1)
			end
			it "assigns new post to @post" do 
				category=Category.create(name:"sample")
				post :create,{:category_id=>category.to_param,:post=>valid_params}
				expect(assigns(:post)).to be_a(Post)
				expect(assigns(:post)).to be_persisted
			end
			it "render post to @post" do 
				category=Category.create(name:"sample")
				post :create,{:category_id=>category.to_param,:post=>valid_params}             #post saved into index
				expect(response).to redirect_to category_post_path(category,Post.last)
			end
		end	
		context "with invalid params" do 

			it "create a post but unsaved post to @post" do
				category=Category.create(name:"sample") 
				post :create,{:category_id=>category.to_param,:post=>invalid_params}          #invalid param 
				expect(assigns(:post)).to be_a_new(Post)
			end
			it "render to new template" do 
				category=Category.create(name:"sample")                                    #post is notsave then render new page
				post :create,{:category_id=>category.to_param,:post=>invalid_params}
				expect(response).to render_template("new")
			end
		end
	end
	describe "GET #show" do 
		it "show page of post" do 
			category=Category.create(name:"sample") 
			post=Post.create!valid_params
			get :show,{:category_id=>category.to_param,:id=>post.to_param}            #display particular post
			expect(assigns(:post)).to eq(post)
		end
		it "post has many comments" do 
			category=Category.create(name:"sample") 
			post=category.posts.create!valid_params
			get :show,{:category_id=>category.to_param,:id=>post.to_param}        #post has many comments
			comment1=post.comments.create(description:"good")
			comment2=post.comments.create(description:"execellent")
			comment3=post.comments.create(description:"good")
			comments=post.comments
			expect(assigns(:post)).to eq(post)
			expect(assigns(:comments)).to eq(comments)

		end
	end
	describe "GET #edit" do 
		it "assigns requested post to @post" do 
			category=Category.create(name:"sample")                              #edit the post
			post=category.posts.create!valid_params
			get :edit,{:category_id=>category.to_param,:id=>post.to_param}
			expect(assigns(:post)).to eq(post)
		end
	end
	describe "PUT #update" do 
		let(:new_params){
			{title:"Playing it my way",description:"Good"}
		}
		context "with valid params" do 
			it "updates the  post as @post" do 
				category=Category.create(name:"sample") 
				post=category.posts.create!valid_params
				get :update,{:category_id=>category.to_param,:id=>post.to_param,:post=>new_params}
				post.reload
			end
			it "assigns requested post to @posts" do 
				category=Category.create(name:"sample") 
				post=category.posts.create!valid_params
				get :update,{:category_id=>category.to_param,:id=>post.to_param,:post=>new_params}
				expect(assigns(:post)).to eq(post)
			end
			it "redirect to post to @post" do 
				category=Category.create(name:"sample") 
				post=category.posts.create!valid_params
				get :update,{:category_id=>category.to_param,:id=>post.to_param,:post=>valid_params}
				expect(response).to redirect_to category_post_path(category,Post.last)
			end
		end
		context "with invalid params" do 
			it "assigns the post as @post" do
		       	category=Category.create(name:"sample") 
				post=category.posts.create!valid_params
				get :update,{:category_id=>category.to_param,:id=>post.to_param,:post=>invalid_params}
		        expect(assigns(:post)).to eq(post)
		    end

		    it "re-renders the 'edit' template" do
		        category=Category.create(name:"sample") 
				post=category.posts.create!valid_params
				get :update,{:category_id=>category.to_param,:id=>post.to_param,:post=>invalid_params}
		        expect(response).to render_template("edit")
		    end
		end

	end
	describe "DELETE #destroy" do
	    it "destroys the requested post" do
	      category = Category.create(name:"sample")
	      post=category.posts.create!valid_params
	      expect {
	        delete :destroy, {:category_id=>category.to_param,:id=>post.to_param,}
	      }.to change(Post, :count).by(-1)
	    end

	    it "redirects to categories posts list" do
	      category = Category.create(name:"sample")
	      post=category.posts.create!valid_params
	      delete :destroy, {:category_id=>category.to_param,:id=>post.to_param,}
	      expect(response).to redirect_to category_posts_path(category)
	    end
  	end

end
