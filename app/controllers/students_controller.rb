class StudentsController < ApplicationController
	def index
		@students=Student.all
		render json: {success: true,students: @students }
	end	
end
