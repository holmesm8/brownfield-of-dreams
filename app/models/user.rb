class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def github_repos
    return nil if self.github_token.blank?
    github_api = GithubFacade.new
    github_api.get_repos(self)[0..4].map do |repo|
      Repo.new(repo)
    end
  end
end
