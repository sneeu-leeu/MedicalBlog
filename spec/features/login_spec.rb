require 'rails_helper'

RSpec.feature 'Logins', type: :feature do # rubocop:todo Metrics/BlockLength
  background { visit new_user_session_path }
  scenario 'displays email form field' do
    expect(page).to have_field('user[email]')
  end

  scenario 'display password form field' do
    expect(page).to have_field('user[password]')
  end

  scenario 'display log in button' do
    expect(page).to have_button('Log in')
  end

  context 'sign in' do
    scenario 'Try sign in with blank form fields' do
      click_button 'Log in'
      expect(page).to have_content 'Invalid Email or password.'
    end

    scenario 'Try sign in with incorrect data' do
      within 'form' do
        fill_in 'Email', with: 'MaxVerstappen@f1.com'
        fill_in 'Password', with: '123456'
      end

      click_button 'Log in'
      expect(page).to have_content 'Invalid Email or password.'
    end

    scenario 'Try sign in with correct data' do
      @user = User.new(name: 'piet', surname: 'pompies', email: 'email@email.com', password: '123456')
      @user.skip_confirmation!
      @user.save
      fill_in 'Email', with: 'email@email.com'
      fill_in 'Password', with: '123456'

      click_button 'Log in'
      sleep(3)
      expect(page).to have_current_path root_path
    end
  end
end
