# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Dashboard Github Repos' do
  vcr_options = { record: :new_episodes }
  it 'as a user I should see a Github section with 5 repos linked', vcr: vcr_options do
    user = User.create!(
      email: 'user1@example.com',
      first_name: 'Test',
      last_name: 'Face',
      password: 'password',
      role: 0,
      github_token: (ENV['GITHUB_API_KEY']).to_s
    )
    user2 = User.create!(
      email: 'user2@example.com',
      first_name: 'Face',
      last_name: 'Test',
      password: 'password',
      role: 0,
      github_token: '234n2l3k42l3knl2kn34lkn2enrk23n4l2kenr2'
    )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    repo_array = 5.times.map { Repo.new(name: 'User 1 Repos', html_url: 'www.github.com') }
    second_repo_array = 5.times.map { Repo.new(name: 'User 2 Repos', html_url: 'www.github.com') }

    allow(user).to receive(:github_repos) { repo_array }
    allow(user2).to receive(:github_repos) { second_repo_array }

    visit '/dashboard'
    within '#github-repos' do
      expect(page).to have_link('User 1 Repos', href: 'www.github.com', count: 5)
      expect(page).not_to have_link('User 2 Repos')
    end
  end

  it 'a user without a github key should not see a github section' do
    user = User.create!(
      email: 'user1@example.com',
      first_name: 'Test',
      last_name: 'Face',
      password: 'password',
      role: 0
    )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).not_to have_css('#github-repos')
  end
end
