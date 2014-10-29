class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User

  validates           :name, presence: true
  validates           :email, uniqueness: { message: 'is already in use' }
  validates           :email, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ }

  before_save do
    self.uid = SecureRandom.uuid
    skip_confirmation!
  end
end
