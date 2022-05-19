require 'rails_helper'

RSpec.describe 'user/user_show', type: :view do
  describe 'users show page' do
    before(:each) do
      @user1 = User.create(name: 'Daniel', surname: 'Stephan', bio: 'bio1', posts_counter: 0,
                           email: 'e@e.com', password: '123456', confirmed_at: Time.now)
      @user2 = User.create(name: 'Van', surname: 'Vicker', photo: 'image-link', bio: 'boi2', posts_counter: 0,
                           email: 'test@test.com', password: 'viesuh45', confirmed_at: Time.now)

      visit root_path
      fill_in 'Email', with: 'e@e.com'
      fill_in 'Password', with: '123456'

      click_button 'Log in'

      @post1 = Post.create(title: 'Blog post', text: 'khduheeuihdfygy jbdfihguir huf', comments_counter: 0,
                           likes_counter: 0, user: @user1)
      @post2 = Post.create(title: 'New rules', text: 'hdfiuek just as it appears in the code', comments_counter: 0,
                           likes_counter: 0, user: @user1)
      @post3 = Post.create(title: 'Another post', text: 'khduheeuihdfygy jbdfihguir huf', comments_counter: 0,
                           likes_counter: 0, user: @user1)

      visit user_path(@user1.id)
    end

    it 'displays user profile photo' do
      all('img').each do |img|
        # rubocop:todo Layout/LineLength
        expect(img[:src]).to eq('/assets/image-placeholder-7f9e46188c7130997159e7d14fe9f4eb1294685586712e2425e01be9fc6cf425.png')
        # rubocop:enable Layout/LineLength
      end
    end

    it 'displays username' do
      expect(page).to have_content('Daniel')
    end

    it 'displays the number of post' do
      user = User.first
      expect(page).to have_content(user.posts_counter)
    end

    it 'displays the bio' do
      user = User.first
      expect(page).to have_content(user.bio)
    end

    it 'displays an all post button' do
      expect(page).to have_button('See all posts')
    end

    it 'displays user first 3 posts' do
      expect(page).to have_content('Blog post')
      expect(page).to have_content('New rules')
      expect(page).to have_content('Another post')
    end

    it 'redirect to user post when click all post button' do
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(@user1.id))
      expect(page).to have_content('Pagination')
    end
  end
end
