require 'rails_helper'

RSpec.describe 'Github Api Service Connection' do
  before :each do
    @user = User.create!(
                      email: 'user1@example.com',
                      first_name: 'Test',
                      last_name: 'Face',
                      password: 'password',
                      role: 0,
                      github_token: "#{ENV['GITHUB_API_KEY']}"
                    )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    GitHub_API = GithubService.new
  end

  it 'can connect to the Github API Repos with creditionals and return array of hashes', :vcr => {record: :once} do

    expect(GitHub_API.get_repos(@user).class).to eq(Array)
    expect(GitHub_API.get_repos(@user)[0].class).to eq(Hash)
  end

  it 'can connect to the Github API Followers with creditionals and return array of hashes', :vcr => {record: :once} do

    expect(GitHub_API.get_followers(@user).class).to eq(Array)
    expect(GitHub_API.get_followers(@user)[0].class).to eq(Hash)
  end
end