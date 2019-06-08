class User < ApplicationRecord
  has_many :posts
  has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  GENDERS = ["Male", "Female", "Other"]
  validates :first_name, presence: true
  validates :surname,    presence: true
  validates :email,      presence: true
  validates :birthday,   presence: true
  validates :gender_id,  presence: true, inclusion: (0..GENDERS.length)
  #has_secure_password

  # Returns the gender string of user according to gender_id
  def gender
    GENDERS[gender_id]
  end
end
