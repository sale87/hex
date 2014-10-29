class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User

  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

  before_save do
    self.uid = SecureRandom.uuid
    skip_confirmation!
  end
end
