class Visitor

  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :email, String, :format => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  property :description, String
  property :contact, Boolean, :default => false

end