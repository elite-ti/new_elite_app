require 'spec_helper'

describe 'Campuses' do
  context 'when logged in as admin' do 
    before(:each) { log_admin_in }

    it 'shows all campuses' do
      5.times { |i| create :campus, name: "Campus#{i}" }
      visit campuses_url
      5.times { |i| page.should have_content "Campus#{i}" }
    end

    it 'creates a campus' do
      visit campuses_url
      click_link 'New Campus'
      fill_in 'Name', with: 'CreatedCampus'
      fill_in 'Code', with: '01'
      click_button 'Create'

      page.should have_content 'Campus was successfully created.'
      page.should have_content 'CreatedCampus'
    end

    it 'updates a campus' do
      create :campus

      visit campuses_url
      click_link 'Edit'
      fill_in 'Name', with: 'UpdatedCampus'
      click_button 'Update'

      page.should have_content 'Campus was successfully updated.'
      page.should have_content 'UpdatedCampus'
    end
  end

  context 'when logged in as campus head teacher' do 
    before(:each) { log_campus_head_teacher_in }

    it 'shows accessible campuses' do
      5.times { |i| create :campus, name: "Campus#{i}" }
      visit campuses_url
      5.times { |i| page.should_not have_content "Campus#{i}" }

      page.should have_content 'AccessibleCampus'
      page.should_not have_content 'Edit'
      page.should_not have_content 'New Campus'
    end

    it 'forbids access to any other page' do 
      visit new_campus_url
      # page.should
    end
  end
end