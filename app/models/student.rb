class Student < ActiveRecord::Base
  # attr_accessible :title, :body
  before_create { generate_token(:auth_token) }

def send_password_reset
  generate_token(:password_reset_token)
  self.password_reset_sent_at = Time.zone.now
  save!
  StudentMailer.password_reset(self).deliver
end

def generate_token(column)
  begin
    self[column] = SecureRandom.urlsafe_base64
  end while Student.exists?(column => self[column])
end

 def self.authenticate(password)
    user = find_by_email(email)
    if user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      return true
    else
      return false
    end
  end

end
