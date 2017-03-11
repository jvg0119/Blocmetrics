require 'rails_helper'

describe "Sign in flow" do 
	describe "successful" do 
		it "redirects to the registered_application index" do
			user = create(:user, name: "Joe")
			user.confirm 
			visit root_path
			within '.navbar-right' do 
				click_link 'Sign In'
			end
			fill_in 'Email', with: 'joe@example.com'
			fill_in 'Password', with: 'password' 
			click_on 'Log in' 
			expect(current_path).to eq registered_applications_path
			#byebug
			#save_and_open_page 
		end
	end
end 	# Sign in flow

describe "Navbar" do
	describe "unsigned" do  
		it "shows 'Home', 'About', 'Sign Up' and 'sign In'" do
			visit root_path
			expect(page).to have_link("Home")
			expect(page).to have_link("About")
			expect(page).to have_link("Sign Up")
			expect(page).to have_link("Sign In")
		end
	end

	describe "signed" do
		it "shows 'Home', 'My Registered Apps', 'About', and 'Sign Out'" do
			user = create(:user)
			user.confirm
			login_as(user, user: :user)
			
			visit root_path
			expect(page).to have_link("Home")
			expect(page).to have_content("My Registered Apps")
			expect(page).to have_link("About")
			expect(page).to have_link("Sign Out")
			#save_and_open_page
		end
	end
end 	# Navbar 




