# == Schema Information
#
# Table name: rits
#
#  id         :integer          not null, primary key
#  code       :string(25)
#  link       :string(255)
#  visits     :integer          default(0)
#  created_at :datetime
#  updated_at :datetime
#

class Rit < ActiveRecord::Base
	
	validates :link, presence: { message: "Where's your link? It's empty!"}
	
	validates :code, format: { with: /\A[a-zA-Z0-9_.-]+\z/,
    message: "Your link only takes letters, numbers, and dashes."}
	validates :code, uniqueness: { message: "That link's been taken already."}
	validates :code, length: { maximum: 25, message: "Your link's too long. 25 characters only, please." }
	validates :code, presence: { message: "Where's your link? It's empty!"}

	def self.make_code
		looping = true
		while looping
			code = SecureRandom.urlsafe_base64(5)	
			looping = false if find_by(code: code) == nil
		end
		code
	end

	def start_with_http
		self.link = "http://#{link}" if URI(self.link).scheme == nil
		self.save
	end

end
