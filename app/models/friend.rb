class Friend < ApplicationRecord
	belongs_to :user
	def self.search_by(search_term)
		where("LOWER(first_name) LIKE :search_term", search_term: "%#{search_term.downcase}")
	end
end
