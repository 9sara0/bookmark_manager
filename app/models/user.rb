require 'bcrypt'
require 'dm-validations'

class User
  include DataMapper::Resource

  property :id,               Serial
  property :name,        String
  property :email,            String, required: true, unique: true
  property :password_digist,  String, length: 60

  attr_accessor :password_confirmation
  attr_reader   :password

  validates_confirmation_of       :password
  validates_format_of :email, as: :email_address


  def password=(password)
    @password = password
    self.password_digist = BCrypt::Password.create(password)
  end


  def self.authenticate(email, password)
    user = first(email: email)
    return user if (user && BCrypt::Password.new(user.password_digist) == password)
    nil
  end
end
