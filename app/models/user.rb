class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :username, :email, :password, :password_confirmation
  
  validates :username, :presence => true,
                       :uniqueness => true
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true,
                    :format => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
  
  p_regex =  /^(?=.*\d)(?=.*[a-z])([\x20-\x7E]){6,40}$/
  # 6-40 characters, at least one lower, and one digit
  validates :password, :confirmation => true,
                       :presence => true,
                       :length => { :within => 6..40 },
                       :format => { :with => p_regex,
                                    :message => "needs to contain at least one numeral."}
  before_create :encrypt_password  
  
  has_many :notes, :dependent => :destroy
  
  def self.authenticate(username_or_email, submitted_password)
     user = find_by_username(username_or_email) || find_by_email(username_or_email)
     return nil if user.nil?
     return user if user.has_password?(submitted_password)
  end
     
  def self.authenticate_with_salt(id, cookie_salt)
     user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
   end
   
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
             
  private
    
  
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
    
end
