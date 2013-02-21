class User < ActiveRecord::Base

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }


  def self.authenticate(email, password)
    usr = Users.find_by_email(email)    
    if usr.password == password
      # direct to secret page
    else
      # direct back to home page
    end
  end
end
