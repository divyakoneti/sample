class CommentsController < ApplicationController
	before_action :set_post,shallow:true
	before_action :set_category,shallow:true
	def index
		@comments=Comment.all
	end
	def new 
	    @comment=Comment.new
	end
	def show
	    @comment=Comment.find(params[:id])
	end
	def edit 
		@comment=Comment.find(params[:id])
	end
	def create
		@comment=Comment.new(comment_params)
		if @comment.save
			redirect_to category_post_comments_path(@comment,@post)
		else
		    render 'new'	
		end
    end
    def update
    	@comment=Comment.find(params[:id])
    	if @comment.update(comment_params)
    		redirect_to category_post_comments_path(@comment,@post)
        else
            render 'edit'		
    	end
    end	
    def destroy
        @comment=Comment.find(params[:id])
        if @comment.destroy
          redirect_to category_post_comments_path(@comment,@post)
        end
    end      	
private
   def comment_params
       params.require(:comment).permit(:post_id,:description)
   end 
   def set_post
       @post=Post.find(params[:post_id])
   end 
   def set_category
    @category=Category.find(params[:category_id])
 end        			

end
