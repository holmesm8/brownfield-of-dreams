# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friendships, foreign_key: :user_id
  has_many :friends, through: :friendships
  has_many :tutorials, through: :videos

  validates :email, uniqueness: true, presence: true
  validates :github_token, uniqueness: true, allow_blank: true
  validates :github_url, uniqueness: true, allow_blank: true
  validates_presence_of :password
  validates_presence_of :first_name, :last_name
  enum role: %i[default admin]
  has_secure_password

  def status
    if email_confirm
      'Status: Activated'
    else
      'Status: Not Verified'
    end
  end

  def api_github_connection
    return nil if github_token.blank?

    GithubService.new
  end

  def github_repos
    api_github_connection.get_repos(self)[0..4].map do |repo|
      Repo.new(repo)
    end
  end

  def github_followers
    api_github_connection.get_followers(self).map do |follower|
      Follower.new(follower)
    end
  end

  def github_followings
    api_github_connection.get_followings(self).map do |following|
      Follower.new(following)
    end
  end

  def self.connected_follow?(url)
    User.find_by(github_url: url.to_s) != nil
  end

  def friendships
    User.find(id).friends
  end

  def friend_check?(url)
    url_array = User.find(id).friends.map(&:github_url)
    !url_array.include?(url)
  end

  def bookmarks_list
    videos = self.videos.joins(:tutorial).select('videos.title, tutorials.title AS tutorial')
    videos.each_with_object(Hash.new { |hash, key| hash[key] = [] }) do |video, acc|
      acc[video[:tutorial]] << video
    end
  end

  def set_confirmation_token
    return unless confirm_token.blank?

    self.confirm_token = SecureRandom.base64(10).to_s
  end
end
