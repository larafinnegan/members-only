class User < ActiveRecord::Base
	attr_accessor :remember_token

	before_create { self.remember_digest = digest(new_token) }

	has_many :posts

	validates :name, presence: true
	validates :username, presence: true
	has_secure_password

	def new_token
		SecureRandom.urlsafe_base64
	end

	def digest(token)
		Digest::SHA1.hexdigest(token)
	end

	def remember
		self.remember_token = new_token
		update_attribute(:remember_digest, digest(remember_token))
	end

	def forget
		update_attribute(:remember_digest, nil)
	end
end
