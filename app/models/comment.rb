class Comment < ActiveRecord::Base
	belongs_to :post
	validates :description ,presence: true
end
