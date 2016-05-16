class CategoriesController < ApplicationController
respond_to :json
def index
		@categories=Category.all
		render json: {success: true, categories: @categories}
       #respond_to do |format|
       	 #format.json {render json.Category.all}
       	 #format.html
       #end	 
 
	end	
	def show
		@category=Category.find(params[:id])
		render json: {success: true, message: "Category has been created", category: @category}  

	end	
	def new
		@category=Category.new
		
	end
	def edit
	    @category=Category.find(params[:id])
	    render json: {success: true, message: "Category has been created", category: @category}  
	end
	def update
	    @category=Category.find(params[:id])
	    if @category.update(category_params)
	    	render json: {success: true, message: "Category has been updated", category: @category}  
	    else
	        render json: {success: false,message: "category has not been updated" ,category: @category}	
	    end
	end    	
	def create
		
	    @category=Category.new(category_params)

	    if @category.save
	    	

	    	 render json: {success: true, message: "Category has been created", category: @category}  
	     
	    else
	        render json: {success: false, message: "category has not been created", category: @category}
	    end
	end
	def destroy
	    @category=Category.find(params[:id])
	    if @category.destroy
	    	render json: {success: true, message: "Category has been deleted", category: @category}  
	    else
	    	render json: {success: false,message: "category has not been deleted", category: @category}
	    end
	end     
private
    def category_params
      params.permit(:name)
    end  	       	
end
