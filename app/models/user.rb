class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable


  has_many :topics
  has_many :videos
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # before_save { self.role ||= :standard }  #happens before validation

  after_initialize :init

  def init
    self.role ||= :standard     # use after_initialize callback to set default(s) for attributes, associations
    # put argus.today logic here???  e.g. set these emails to default to admin?
  end

  enum role: [:standard, :admin]

  def favorite_for(video)
    favorites.where(video_id: video.id).first
  end

  def favorited_videos
    favorites.includes( video: :topic ).map(&:video)
  end 

end
