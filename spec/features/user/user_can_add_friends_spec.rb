# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Dashboard Friendships' do
  before(:each) do
    user = User.create!(
      email: 'user1@example.com',
      first_name: 'Test',
      last_name: 'Face',
      password: 'password',
      role: 0,
      github_token: (ENV['GITHUB_API_KEY']).to_s,
      github_url: 'https://github.com/rcallen89'
    )
    user2 = User.create!(
      email: 'user2@example.com',
      first_name: 'Matt',
      last_name: 'Holmes',
      password: 'password',
      role: 0,
      github_token: (ENV['GITHUB_TEST_KEY']).to_s,
      github_url: 'https://github.com/holmesm8'
    )
    user3 = User.create!(
      email: 'user3@example.com',
      first_name: 'Test',
      last_name: 'Face',
      password: 'password',
      role: 0
    )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  it 'should see a friendship button next to github follower/ings to add friend', :vcr do
    visit '/dashboard'

    within '#github-followers' do
      expect(page).to have_button('Add as Friend', count: 1)
    end

    within '#github-following' do
      expect(page).to have_button('Add as Friend', count: 1)
    end

    within '#github-followers' do
      click_on 'Add as Friend'
    end

    expect(current_path).to eq(dashboard_path)

    within '#friends' do
      expect(page).to have_content('Matt Holmes')
    end
  end
end
