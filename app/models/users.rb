require 'bcrypt'

class Users < ActiveRecord::Base
  user :database_authenticatable, :recoverable, :rememberable, :trackable,
    :validatable, :registerable, :confirmable
    
  attr_accessible :email, :password, :password_confirmation
  attr_accessor :password
  before_save :encrypt_password
  
  def encrypt_password
    if password.present?
      self.password = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
    
end
