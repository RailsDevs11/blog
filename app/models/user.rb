class User < ActiveRecord::Base

  #define constant for profile completeness
  PROFILE_ATTRIBUTES = [:email, :first_name, :last_name, :address, :city, :state, :zip_code, :country, :username]

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable, :confirmable, :authentication_keys => [:login]

  #Define attribute accessor
  attr_accessible :email, :password, :password_confirmation, :current_password, :remember_me, :first_name,
    :last_name, :username, :terms_of_service, :email_confirmation, :login
  attr_accessor :current_password, :login
  
  #Define validation for every attribute
  validates :first_name, :presence => true, :format => { :with => /^[a-zA-Z ]+$/, :message => "Only letters allowed"  }
  validates :last_name, :presence => true, :format => { :with => /^[a-zA-Z ]+$/, :message => "Only letters allowed"  }
  validates :email, :presence => true, :format => { :with => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/ }
  validates :terms_of_service, :on => :create, :acceptance => true
  validates :username, :allow_blank => true, :uniqueness => true, :format => { :with => /^[\w]{4,}$/, :message => "should at-least contain 4 valid characters" }

  #define association
  has_many :posts, :dependent => :destroy
  has_many :likes, :dependent => :destroy
  has_many :comments, :through => :posts
  
  #return the true if profile is completed
  def is_profile_complete?
    @complete_attributes_count = 0
    PROFILE_ATTRIBUTES.each do |att|
      @complete_attributes_count += 1 if self[att].present?
    end
    @complete_attributes_count.to_i === PROFILE_ATTRIBUTES.size
  end

  #show the completeness of the profile 
  #how many percentage complete profile
  def profile_complete_in_per
    return "100" if is_profile_complete? === true
    per = (@complete_attributes_count * 100) / PROFILE_ATTRIBUTES.size
    return per
  end

  #by default devise provides login with email
  #If also need to login with username then need to overrides this method
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  
  #Fetch the full name of the user
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  #Fetch latest 3 post to show on dashboard area
  #created_at desc will show last created post
  def recent_posts
    self.posts.limit(5).order('created_at DESC')
  end
  
  #Fetch latest 3 comments 
  def recent_comments
    self.comments.limit(5).order('created_at DESC')
  end
end
