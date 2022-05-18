require 'rails_helper'

RSpec.describe "user/user_show", type: :view do
  describe "users show page" do
    before(:each) do
      @user1 = User.create(name: "Daniel", surname: "Stephan", photo: "image-link", bio: "integration spec is a behaviour driven development tool", posts_counter: 0,
      email: "huhou@test.com", password: "huhuhuh45", confirmed_at: Time.now)
      @user2 = User.create(name: "Van", surname: "Vicker", photo: "image-link", bio: "integration spec is a behaviour driven development tool", posts_counter: 0,
      email: "test@test.com", password: "vibesuh45", confirmed_at: Time.now)

      visit root_path
      fill_in 'Email', with: "huhou@test.com"
      fill_in 'Password', with: "huhuhuh45"

      click_button 'Log in'

      @post1 = Post.create(title: "Blog post", text: "khduheeuihdfygy jbdfihguir huf", comments_counter: 0, likes_counter: 0, user: @user1)
      @post2 = Post.create(title: "New rules", text: "hdfiuek just as it appears in the code", comments_counter: 0, likes_counter: 0, user: @user1)
      @post3 = Post.create(title: "Annother post", text: "khduheeuihdfygy jbdfihguir huf", comments_counter: 0, likes_counter: 0, user: @user1)
    
      visit user_path(@user1.id)
    end

    it "displays user profile photo" do
      all('img').each do |image|
        expect(image[:src]).to eq("assets/image-placeholder.png")
      end
    end


    it "displays username" do
      expect(page).to have_content ("Daniel")
    end

    it "displays the number of post" do
      user = User.first
      expect(page).to have_content(user.posts_counter)
    end

    it "displays the first three post" do
      expect(page).to have_content("Blog post")
      expect(page).to have_content("New rules")
      expect(page).to have_content("Another post")
    end

    it "displays an all post button" do
      expect(page).to have_buttons("See all posts")
    end

    it "redirect to user post when click all post button" do
      click_link "See all posts"
      expect(page).to have_content("Pagination")
    end
  end
end
