class User < ActiveRecord::Base
  def self.authenticate(email, password)
    usr = Users.find_by_email(email)    
    if usr.password == password
      # direct to secret page
    else
      # direct back to home page
    end
  end
end
