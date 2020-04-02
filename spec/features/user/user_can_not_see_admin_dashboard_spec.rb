require 'rails_helper'

RSpec.describe 'User Restrictions' do
  it 'will return 404 if visitor tries to access admin page' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit admin_dashboard_path

    expect(page).to have_content('No access')
  end
end