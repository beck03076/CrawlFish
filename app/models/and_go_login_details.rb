class AndGoLoginDetails < ActiveRecord::Base

  def self.authenticate(andgo)

    login_name = andgo[:login_name]

    password = andgo[:password]

    user = where(:login_name => login_name).first

    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)

      user

    else

      nil

    end

  end

end
