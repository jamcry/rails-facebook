class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :friendships
  has_many :friends, through: :friendships
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

  def full_name
    "#{first_name.capitalize} #{surname.capitalize}"
  end

  # Create bidirectional friendship between self and given user
  def make_friends_with(other_user)
    if (self != other_user) && !self.friends.include?(other_user)
      self.friendships.create!(friend: other_user)
      other_user.friendships.create!(friend: self)
    end
  end

  # Returns true if user is friends with other_user
  def friends_with?(other_user)
    friends.include?(other_user)
  end

  # Returns latest posts feed from friends and user
  def feed
    Post.where("user_id IN (?) OR user_id = ?", friend_ids, id).feed
  end
end
