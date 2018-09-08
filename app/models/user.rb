class User < ActiveRecord::Base

  attr_accessor :password
  attr_accessor :password_confirmation
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name, :presence => true, :length => { :in => 3..20 }
  validates :surname, :presence => true, :length => { :in => 3..20 }
  validates :nickname, :presence => true, :length => { :in => 3..20 }
  validates :gender, :presence => true
  validates :email, :presence => true, :uniqueness => true#, :format => EMAIL_REGEX
  validates :birthdate, :presence => true
  #validates :description, :length => { :in => 1..256 }
  validates :password, :confirmation => true #password_confirmation attr
  validates_length_of :password, :in => 6..20, :on => :create

  before_save :encrypt_password
  after_save :clear_password

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end

  def self.authenticate(username_or_email="", login_password="")
    if  EMAIL_REGEX.match(username_or_email)
      user = User.find_by_email(username_or_email)
    else
      user = User.find_by_nickname(username_or_email)
    end
    if user && user.match_password(login_password)
      return user
    else
      return false
    end
  end

  def match_password(login_password="")
    encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
  end

end
