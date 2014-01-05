class Admin

  include DataMapper::Resource

  property :id, Serial
  property :email, String
  
end