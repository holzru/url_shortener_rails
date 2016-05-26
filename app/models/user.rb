class User < ActiveRecord::Base
  validates :email, uniqueness: true, presence: true

  has_many :shortened_urls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :ShortenedUrl

  has_many :visited_urls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :ShortenedUrl

end
