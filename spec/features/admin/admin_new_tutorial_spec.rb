require 'rails_helper'

RSpec.describe 'Admin New Tutorial' do
  before :each do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
  end

  it 'can create a new tutorial' do
    visit new_admin_tutorial_path
    fill_in 'tutorial_title', with: "Test Tutorial"
    fill_in 'tutorial_description', with: "Test Description"
    fill_in 'tutorial_thumbnail', with: "http://cdn3-www.dogtime.com/assets/uploads/2011/03/puppy-development-460x306.jpg"
    click_on "Save"

    expect(current_path).to eq("/tutorials/#{Tutorial.last.id}")

    expect(page).to have_content("Test Tutorial")
    expect(page).to have_content("Successfully created tutorial.")

    visit root_path

    expect(page).to have_content("Test Tutorial")
    expect(page).to have_content("Test Description")
    expect(page).to have_css("img[src*='http://cdn3-www.dogtime.com/assets/uploads/2011/03/puppy-development-460x306.jpg']")
  end

  it 'will see an error if not all info is filled in' do
    visit new_admin_tutorial_path
    fill_in 'tutorial_title', with: "Test Tutorial"
    fill_in 'tutorial_thumbnail', with: "http://cdn3-www.dogtime.com/assets/uploads/2011/03/puppy-development-460x306.jpg"
    click_on "Save"

    expect(page).to have_content("Please fill in all fields. Description can't be blank")
  end
end