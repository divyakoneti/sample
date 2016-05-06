 class PostsController < ApplicationController
    before_action :set_category,shallow:true
    def index
        @posts=Post.all
    end
    def new
   @post=Post.new
 end
 def create

   @post=@category.posts.build(post_params)
   if @post.save
     redirect_to category_post_path(@category,@post)
   else
     render "new"
   end
 end
 def show
   @post=Post.find(params[:id])
   @comment=@post.comments.create(description:"good")
   @comments=@post.comments
 end
 def edit
   @post=Post.find(params[:id])
 end
 def update
  @post=Post.find(params[:id])
   if @post.update(post_params)
    redirect_to category_post_path(@category,@post)
   else
    render "edit" 
  end
 end
 def destroy
  @post=Post.find(params[:id])
  if @post.destroy
    redirect_to category_posts_path(@category)
  end
 end
 private
  def post_params
    params.require(:post).permit(:title,:description,:category_id)
  end
  def set_category
    @category=Category.find(params[:category_id])
 end
end
