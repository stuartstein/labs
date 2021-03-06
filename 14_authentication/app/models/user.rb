# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  #validations on sign up form
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, 	presence:   true,
                    	format:     { with: VALID_EMAIL_REGEX },
                    	uniqueness: { case_sensitive: false }
  validates :password,	presence: true, length: { minimum: 6 },
                    	confirmation: true
  validates :password_confirmation, presence: true

  #creates password_digest
  has_secure_password

  def create_remember_token
 	self.remember_token = SecureRandom.urlsafe_base64
  end


end