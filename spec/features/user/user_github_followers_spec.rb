require 'rails_helper'

RSpec.describe 'User Dashboard Github Followers' do
  vcr_options = {:record => :new_episodes }
  it 'as a user I should see a Github section with all followers with handles as links to their Github profile ', :vcr => vcr_options do
    user = User.create!(
                      email: 'user1@example.com',
                      first_name: 'Test',
                      last_name: 'Face',
                      password: 'password',
                      role: 0,
                      github_token: "#{ENV['GITHUB_API_KEY']}"
    )
    user2 = User.create!(
                      email: 'user2@example.com',
                      first_name: 'Face',
                      last_name: 'Test',
                      password: 'password',
                      role: 0,
                      github_token: "234n2l3k42l3knl2kn34lkn2enrk23n4l2kenr2"
    )
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    followers_array1 = 5.times.map {Follower.new(login: "Follower", html_url: "www.github.com")}
    followers_arrays2 = 5.times.map {Follower.new(login: "2nd Follower", html_url: "www.cnn.com")}

    allow(user).to receive(:github_followers) {followers_array1}
    allow(user2).to receive(:github_followers) {followers_array2}
  
    visit '/dashboard'

    within '#github-followers' do
      expect(page).to have_link('Follower', href: 'www.github.com', count: 5)
      expect(page).not_to have_link('2nd Follower')
    end
  end
end
