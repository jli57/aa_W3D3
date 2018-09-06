# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord
  validates :long_url, :short_url, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Visit

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :user

  def self.random_code
    res = SecureRandom.urlsafe_base64[0...16]
    while exists?(short_url: res)
      res = SecureRandom.urlsafe_base64[0...16]
    end
    res
  end

  def self.generate_short_url(user, long_url)
    ShortenedUrl.create!(user_id: user.id,
      long_url: long_url,
      short_url: ShortenedUrl.random_code)
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    self.visitors.where("visits.created_at >= '#{10.minutes.ago}'").count
  end

end
