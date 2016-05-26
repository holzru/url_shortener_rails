class ShortenedUrl < ActiveRecord::Base
  validates :long_url, :short_url, :user_id, presence: true
  validates :short_url, uniqueness: true

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Visit

  has_many :visitors,
    through: :visits,
    source: :user

  has_many :taggings,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Tagging

  has_many :tag_topics,
    through: :taggings,
    source: :tag_topic

  def self.random_code
    random_url = SecureRandom::urlsafe_base64
    self.random_code if ShortenedUrl.exists?(short_url: random_url)
    random_url
  end

  def self.create_for_user_and_long_url!(user, long_url)
    return "I don't appreciate this much attention!" unless self.recent_urls_made(user)
    ShortenedUrl.create!(user_id: user.id, long_url: long_url, short_url: self.random_code)
  end

  def num_clicks
    visits.count
  end

  def self.recent_urls_made(user)
    recent_made = ShortenedUrl.all.where(user_id: user.id, created_at: ((Time.now - 1.minute)..(Time.now))).count
    recent_made <= 5
  end


  def num_uniques
    visits.select(:user_id).distinct.count
  end

  def num_recent_uniques
    visits.select(:user_id).distinct.where({ created_at: ((Time.now.midnight - 1.day)..(Time.now.midnight + 1.day)) }).count
  end
end
