require 'bcrypt'

class Admin

  include DataMapper::Resource

  property :id, Serial
  property :email, String,  :required => true,
                            :unique => true, 
                            :format => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
                            :messages => {
                              :is_unique => "The email you have entered is already taken. Please try again",
                              :format    => "The email you have entered is not valid. Please try again"
                            }
  property :password_digest, Text,  :required => true, 
                                    :message => "Please enter your password"
  property :super_admin, Boolean, :default => false

  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password
  validates_uniqueness_of :email

  def super_admin?
    self.super_admin
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
  admin = first(:email => email)
    if admin && BCrypt::Password.new(admin.password_digest) == password
      admin
    else
      nil
    end
  end

  def update_fields_with_auth(params, current_password, current_admin)
    if Admin.authenticate(current_admin.email, params[:current_password])
      fields = [:email, :password, :password_confirmation]
      fields.each { |f| params.delete(f) if params[f] == "" }
      fields.each { |f| self.update(f => params[f]) if params[f] != nil }
    end
  end

end