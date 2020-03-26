require 'rails_helper'

RSpec.describe 'User Dashboard Github OAuth Connect' do
  before(:each) do
    OmniAuth.config.mock_auth[:github] = nil
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      {"provider" => "github",
      "info" => {"name" => "Matt Holmes"},
      "credentials" =>
        {"token" => ENV["GITHUB_TEST_KEY"],
        "expires" => false},
      "extra" =>
        {"raw_info" =>
          {"login" => "matt-holmes",
           "html_url" => "https://github.com/matt-holmes",
           "name" => "Matt Holmes",
           }}})
  end

  it "as a user I can login and connect to Github", :vcr do
    user = User.create!(
                      email: 'user1@example.com',
                      first_name: 'Test',
                      last_name: 'Face',
                      password: 'password',
                      role: 0
    )
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    repo_array = 5.times.map { Repo.new(name: "User 1 Repos", html_url: "www.github.com") }
    followers_array1 = 5.times.map {Follower.new(login: "Follower", html_url: "www.github.com")}
    following_array1 = 5.times.map {Follower.new(login: "Following", html_url: "www.github.com")}

    allow(user).to receive(:github_repos) {repo_array}
    allow(user).to receive(:github_followers) {followers_array1}
    allow(user).to receive(:github_followings) {following_array1}

    visit "/dashboard"
    
    click_on "Connect to Github"

    expect(current_path).to eq(dashboard_path)
    expect(user.github_token).to eq("#{ENV["GITHUB_TEST_KEY"]}")

  end
end