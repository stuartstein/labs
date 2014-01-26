class Rit < ActiveRecord::Base
	validates :link, format: { with: /\A[a-zA-Z]+\z/,}
	validates :code, format: { with: /\A[a-zA-Z0-9_.-]+\z/}
	validates :code, uniqueness: true
	validates :code, length: { maximum: 25 }
	

	def self.make_code
		looping = true
		while looping
			code = SecureRandom.urlsafe_base64(5)	
			looping = false if find_by(code: code) == nil
		end
		code
	end

end
