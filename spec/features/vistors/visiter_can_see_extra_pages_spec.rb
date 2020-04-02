require 'rails_helper'

RSpec.describe 'Getting Started And About Page' do
  it 'has a getting started page' do
    visit get_started_path

    expect(page).to have_content('Browse tutorials from the homepage.')
  end

  it 'has an about page' do
    visit about_path

    expect(page).to have_content('This application is designed to pull in youtube information')
  end
end