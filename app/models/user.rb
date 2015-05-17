class User < ActiveRecord::Base
	
	enum role: [:user, :mod, :supermod]
	after_initialize :set_default_role, :if => :new_record?

	def set_default_role
	    self.role ||= :user
	end

	has_many :question, dependent: :destroy
	has_many :relationships, foreign_key: 'follower_id', dependent: :destroy
	has_many :following, through: :relationships, source: :followed

	has_many :reverse_relationships, foreign_key: 'followed_id', 
									class_name: 'Relationship',
									dependent: :destroy
	has_many :followers, through: :reverse_relationships, source: :follower

	has_many :answers, dependent: :destroy
  	# Include default devise modules. Others available are:
  	#:confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

    validates :phone, format: { with: /\d{3}-\d{3}-\d{4}/ || /\d{4}-\d{3}-\d{4}/, message: "Invalid phonenumber" }
  	devise :omniauthable, :omniauth_providers => [:facebook]
  	# Omniauth 
  	def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
      end
  	end

	def self.new_with_session(params, session)
	    super.tap do |user|
	      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
	        user.email = data["email"] if user.email.blank?
	      end
	    end
	end
	# End Omniauth
	# Follow
	def self.authenticate_with_salt(id, stored_salt)
		
	end

	def following?(followed)
		relationships.find_by_followed_id(followed)
	end

	def follow!(followed)
		relationships.create!(:followed_id => followed.id)
	end

	def unfollow!(followed)
		relationships.find_by_followed_id(followed).destroy
	end
end
