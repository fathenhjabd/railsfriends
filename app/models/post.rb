class Post < ApplicationRecord
	belongs_to :user
	validates :title, :content, :user_id, presence: true
	def self.search_by(search_term)
		where("LOWER(title) LIKE :search_term", search_term: "%#{search_term.downcase}")
	end
end
