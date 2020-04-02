# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Invite Github', type: :feature do
  before :each do
    user = User.create!(
      email: 'user1@example.com',
      first_name: 'Test',
      last_name: 'Face',
      password: 'password',
      role: 0,
      github_token: (ENV['GITHUB_API_KEY']).to_s,
      github_url: 'https://github.com/rcallen89'
    )
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  it 'a user can send an invite via Github handle', :vcr do
    allow_any_instance_of(GithubService).to receive(:user_info).and_return({ name: 'Ryan Allen', email: 'tester@email.com' },
                                                                           { name: 'Test', email: 'test@email.com' })
    visit dashboard_path

    click_on 'Send an Invite'

    expect(current_path).to eq('/invite')

    fill_in :invite_github_handle, with: 'holmesm8'
    click_on 'Send Invite'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Successfully sent invite!')
  end

  it 'a user can not invite without proper github handle', :vcr do
    visit dashboard_path

    click_on 'Send an Invite'

    expect(current_path).to eq('/invite')

    fill_in :invite_github_handle, with: 'holmesm8'
    click_on 'Send Invite'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end
end
