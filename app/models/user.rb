class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles
  has_many :favorites, dependent: :destroy
  has_many :favorite_articles, through: :favorites, source: :article
  has_many :reviews, dependent: :destroy
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: true
  has_many :followers, through: :reverse_of_relationships, source: :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :drink_coffee
  belongs_to :job

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  # freezeメソッドで、オブジェクトの値変化を不可能に(破壊的メソッドへの対策)
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めてください', on: :create
  validates :job_id, :drink_coffee_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :nickname, presence: true

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow
    realtionship = self.relationships.find_by(follow_id: other_user.id)
    realtionship.destroy if realtionship
  end

  def following?(other_user)
    self.followings.include(other_user)
  end
end
