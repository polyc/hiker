class User < ActiveRecord::Base

  has_many :comments
  has_many :hikes, :dependent => :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships


  has_many :active_favorite_relationships, class_name: "Favorite", foreign_key: "favoriter_id", dependent: :destroy
  has_many :favorites, through: :active_favorite_relationships, source: :favoritable


  has_many :active_ban_relationships, class_name: "Ban", foreign_key: "condemner_id", dependent: :destroy
  has_many :condemning, through: :active_ban_relationships, source: :banned

  has_many :passive_ban_relationships, class_name: "Ban", foreign_key: "banned_id", dependent: :destroy
  has_many :condemners, through: :passive_ban_relationships





  devise :omniauthable, omniauth_providers: %i[facebook]

  mount_uploader :image, ImageUploader

  attr_accessor :password
  attr_accessor :password_confirmation

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name, :presence => true, :length => { :in => 3..20 }
  validates :surname, :presence => true, :length => { :in => 3..20 }
  validates :nickname, :presence => true,:uniqueness => true, :length => { :in => 3..20 }
  validates :gender, :presence => true, :inclusion => { :in => %w(male female not-specified)}
  validates :email, :presence => true, :uniqueness => true ,format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :birthdate, :presence => true
  validates :password, :confirmation => true #password_confirmation attr
  validates_length_of :password, presence: true, :in => 6..20, :on => :create, allow_nil: true
  validate :image_size
  validate :check_city

  before_save :encrypt_password
  after_save :clear_password

  def check_city
    result = Geocoder.search(city)
    if result.empty? || result.nil?
      result = false
    else
      result = true
    end
  end

    # Validates the size of an uploaded picture.
  def image_size

    if self.image.size > 1.megabytes
      errors[:image] << "should be less than 1MB"
    end
  end

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def clear_password
    self.password = nil
    self.password_confirmation = nil
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

  #third party auth methods
  #########################

  def self.from_omniauth(auth)
   where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.first_name
      user.surname = auth.info.last_name
      user.nickname = auth.info.name
      user.gender = "not-specified"
      user.city = "Rome" #default because facebook doesn't return it
      user.birthdate = "2018-09-28 00:00:00"
    end
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def banned?(other_user)
    condemning.include?(other_user)
  end

  def unban(other_user)
    condemning.delete(other_user)
  end

end
