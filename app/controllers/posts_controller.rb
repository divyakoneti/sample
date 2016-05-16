 class PostsController < ApplicationController
    before_action :set_category,shallow:true
    def index
        @posts=Post.all
        render json: {success: true, posts: @posts}
    end
    def new
   @post=Post.new
 end
 def create

   @post=@category.posts.build(post_params)
   if @post.save
    render json: {success: true, message: "post has been created", post: @post}  
   else
     render json: {success: false , message: "post has not been created",post: @post}
   end
 end
 def show
   @post=Post.find(params[:id])
   @comment=@post.comments.create(description:"good")
   @comments=@post.comments
 end
 def edit
   @post=Post.find(params[:id])
     render json: {success: true, message: "post has been edited", post: @post}  
 end
 def update
  @post=Post.find(params[:id])
   if @post.update(post_params)
    render json: {success: true, message: "post has been updated", post: @post}  
   else
    render json: {success: false, message: "post has not been updated",post: @post}  
  end
 end
 def destroy
  @post=Post.find(params[:id])
  if @post.destroy
    render json: {success: true ,message: "post has been deleted",post: @post}
  else
    render json: {success: false,message: "post has not been delete",post: @post}  
  end
 end
 private
  def post_params
    params.permit(:title,:description,:category_id)
  end
  def set_category
    @category=Category.find(params[:category_id])
 end
end
