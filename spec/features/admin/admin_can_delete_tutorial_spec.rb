# frozen_string_literal: true

require 'rails_helper'

feature 'An admin can delete a tutorial' do
  scenario 'and it should no longer exist' do
    admin = create(:admin)
    create_list(:tutorial, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/dashboard'

    expect(page).to have_css('.admin-tutorial-card', count: 2)

    within(first('.admin-tutorial-card')) do
      click_link 'Delete'
    end

    expect(page).to have_css('.admin-tutorial-card', count: 1)
  end

  it 'admin can delete tutorial and it will delete the videos with it' do
    admin = create(:admin)
    tutorial1 = create(:tutorial)
    tutorial2 = create(:tutorial)

    video1 = create(:video, tutorial_id: tutorial1.id)
    video2 = create(:video, tutorial_id: tutorial1.id)
    video3 = create(:video, tutorial_id: tutorial2.id)
    video4 = create(:video, tutorial_id: tutorial2.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/dashboard'

    expect(page).to have_css('.admin-tutorial-card', count: 2)

    within(first('.admin-tutorial-card')) do
      expect do
        click_link 'Delete'
      end.to change { Video.count }.by(-2)
    end

    expect(page).to have_css('.admin-tutorial-card', count: 1)
  end
end
