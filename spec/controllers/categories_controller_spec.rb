require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

let(:valid_attributes) {               #this is used reaptedly
    {name: 'jokes'}
  }

  let(:invalid_attributes) {
   {name: nil}
  }



  describe "GET #index" do
  	it "should go to index page when contact save successful" do     #index action test case
	  category=Category.create(name: 'fiction')
	  category1=Category.new(name: 'nonfiction')
	  category1.save
	  get :index 	
	  expect(assigns(:categories)).to eq([category,category1])  
	end
  end	
  describe "GET #show" do
    it "store the requested category as @category" do
      category=Category.create(name: 'entertainment')                #show action test case
      get :show, {:id => category.to_param}
      expect(assigns(:category)).to eq(category)
    end
     
  end
  describe "GET #new" do
    it "stored requested category as @category" do                  #new action test case
      get :new
      expect(assigns(:category)).to be_a_new(Category) 
    end
  end
  describe "GET #edit" do 
    it "stored requested category as @category" do                #edit action test case
      category=Category.create! valid_attributes
      get :edit,{:id => category.to_param}
      expect(assigns(:category)).to eq(category)
    end
 end  
 describe "POST #create" do
   context "with valid params" do
     it "creates new category" do                              #create action test case
       expect{
       	post :create,{:category =>{name: 'jokes'} }
       }.to change(Category, :count).by(1)
     end
     it "stored category as @category" do
       post :create, {:category => valid_attributes} 
       expect(assigns(:category)).to be_a(Category)
     end
     it "redirects to the created book" do
       post :create,{:category => valid_attributes} 
       expect(response).to redirect_to(categories_path)
     end
    end
   context "with invalid params" do
     it "assign a new category but not saved" do
     post :create,{:category => invalid_attributes}         #create fails action
     expect(assigns(:category)).to be_a_new(Category)
     end
     it "re renders the new template" do
     	post :create,{:category => invalid_attributes}
     	expect(response).to render_template("new")
     end
    end 	
   end 
  describe "PUT #update" do
    context "with valid params" do                            
      let(:new_attributes) {
        {name: 'comedy'}
      }
      it "updated requested category" do
        category=Category.create! valid_attributes 
        put :update,{:id => category.to_param, :category => new_attributes}          #update action test case
      end
      it "assigns the requested category as @category" do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => valid_attributes}
        expect(assigns(:category)).to eq(category)
      end
      it "redirects to category " do
        category=Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => valid_attributes}
        expect(response).to redirect_to(categories_path)
      end
     context "with invalid params" do 
     it "assigns the category as @category" do
        category = Category.create! valid_attributes
        puts category.inspect
        put :update, {:id => category.id, :category  => invalid_attributes}           #update fails action   
        expect(assigns(:category)).to eq(category)
      end
      it "render edit form" do
        category=Category.create! valid_attributes
        put :update,{:id => category.to_param,  :category=> invalid_attributes} 
        expect(response).to render_template("edit")
      end
     end     
     end 
    end    
  describe "DELETE #destroy" do
    it "destroys the requested category" do
      category = Category.create! valid_attributes                 #delete action test case
      expect {
        delete :destroy, {:id => category.to_param}
      }.to change(Category, :count).by(-1)
    end
    it "redirects to index page" do
      category = Category.create! valid_attributes
      delete :destroy, {:id => category.to_param} 
      expect(response).to redirect_to categories_path
    end

  end

end



	

