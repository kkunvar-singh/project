class User < ApplicationRecord
  has_secure_password

  validates :first_name, :last_name, :mobail_number, :date_of_birth, :role, presence: true
  validates :email, presence: true, uniqueness: true, 
  format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }

  validates :mobail_number, length: {minimum: 10, maximum: 10}
  validates :password, length: { maximum: 10}

  has_one :address, :dependent => :destroy
  accepts_nested_attributes_for :address

  enum :role, { user: 0, admin: 1 }
  enum :type_otp, { record_create: 0, forget_password: 1, confirmed: 2 }

  
  def status
    confirmed? || forget_password? ? 'Confirmed' : 'Pending'
  end

end
