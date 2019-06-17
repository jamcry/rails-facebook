class User < ApplicationRecord
  has_many :posts,       dependent: :destroy
  has_many :comments,    dependent: :destroy
  has_many :likes,       dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :friendship_requests, dependent: :destroy
  has_many :pending_friends, through: :friendship_requests,
                             source: :requested_user
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]
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

  # Remove bidirectional friendship between self and given user
  def unfriend(other_user)
    @friendship = user.friendships.find_by(friend: other_user)
    @friendship.destroy
  end

  # Returns true if user is friends with other_user
  def friends_with?(other_user)
    friends.include?(other_user)
  end

  # Returns latest posts feed from friends and user
  def feed
    Post.where("user_id IN (?) OR user_id = ?", friend_ids, id).feed
  end

  # Returns friendship requests sent to the user if any, returns nil otherwise
  def recieved_requests
    FriendshipRequest.where("requested_user_id = ?", id)
  end

  # Returns list of users who sent friendship requests to current user
  def recieved_requests_users
    recieved_requests.map(&:user)
  end

  # Create a new friendship requests from user to other_user
  def send_friendship_request(other_user)
    friendship_requests.create!(requested_user: other_user) if !self.friends_with?(other_user)
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      name = auth.info.name.split
      user.first_name = auth.info.name.split.first
      user.surname    = auth.info.name.split.last
      user.email      = auth.info.email
      user.password   = Devise.friendly_token[0, 20]
      user.image      = auth.info.image
      user.gender_id  = 2
      user.birthday   = Time.new
      # If user is :confirmable, uncomment the following line
      # to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
