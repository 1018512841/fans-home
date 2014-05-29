class User
  include MongoMapper::Document
  attr_accessor :password, :password_confirmation


  key :user_name, String, :required => true
  key :encrypted_password, String
  timestamps!

end
