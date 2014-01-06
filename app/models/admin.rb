require 'bcrypt'

class Admin

  include DataMapper::Resource

  property :id, Serial
  property :email, String, :unique => true, :message => "This email is already taken"
  property :password_digest, Text

  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password
  validates_uniqueness_of :email

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

end