class Post < ActiveRecord::Base
	belongs_to :category
	has_many :comments
	validates :title ,presence: true,length: {minimum: 3}
	validates :description , presence: true
end
