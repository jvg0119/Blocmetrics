require 'rails_helper'

describe "Registered Application" do 
	let(:my_user) { create(:user, name: "Joe") }
	let(:another_user) { create(:user, name: "George") }
	let(:my_registered_application) { create(:registered_application, user: my_user) }
	let(:another_registered_application) { create(:registered_application, name: "another-app", url: "another-app.com", user: another_user) }
	before do 
		login_as(my_user, user: :my_user)
		my_user.confirm
		#byebug
	end

	describe "Viewing the index of registered_applications" do
		it "shows the current_user's registered_applications only" do
			my_registered_application
			another_registered_application
			visit registered_applications_path
			expect(current_path).to eq(registered_applications_path)
			expect(page).to have_content(my_registered_application.name)
			expect(page).to_not have_content(another_registered_application.name)
			#save_and_open_page 
		end
	end 	# Viewing the list of registered_applications

	describe "Viewing individual registered_application" do
		it "shows the registered_application's details" do
			visit registered_application_path(my_registered_application)
			expect(current_path).to eq(registered_application_path my_registered_application)
			expect(page).to have_content(my_registered_application.name)
			expect(page).to have_content(my_registered_application.url)
			#save_and_open_page
		end
	end		# "Viewing individual event"

	describe "Navigating registered_applications" do
		it "allows navigation from home(root) page to #index page" do
			my_registered_application
			visit root_path
			click_link("My Registered Apps")
			expect(current_path).to eq(registered_applications_path)
			expect(page).to have_content(my_registered_application.name)
		end
		it "allows navigation from #index page to #show page" do
			my_registered_application
			visit registered_applications_path
			click_link(my_registered_application.name)
			expect(current_path).to eq(registered_application_path(my_registered_application))
			#save_and_open_page
		end
		it "allows navigation from #show page to #index page" do
			visit registered_application_path(my_registered_application)
			expect(current_path).to eq(registered_application_path(my_registered_application)) 
			click_link("All registered applications")
			expect(current_path).to eq(registered_applications_path)
			#save_and_open_page
		end
	end 	# Navigating registered_applications

	describe "Editing registered_application" do
		before do 
			visit registered_application_path(my_registered_application)
			click_link("Edit")
			expect(current_path).to eq(edit_registered_application_path(my_registered_application))
			expect(find_field('Name').value).to eq(my_registered_application.name)
			expect(find_field('Url').value).to eq(my_registered_application.url)
		end
		it "updates the registered_application and shows it's updated details" do
			fill_in('Name', with: 'Updated name')
			click_button("Update Registered application")
			expect(current_path).to eq(registered_application_path(my_registered_application))
			expect(page).to have_content("Updated name")
			#save_and_open_page
		end
		it "does not update the registered_application if it has invalid attributes" do
			fill_in('Name', with: '')
			fill_in('Url', with: 'test-url')
			click_button("Update Registered application")
			expect(current_path).to eq(registered_application_path(my_registered_application))
			expect(page).to_not have_content("test-url")
			expect(page).to have_content("There was an error updating the Registered Application. Please try again.")
		end
	end 	# Editing an registered_application 

	describe "Creating registered_application" do
		before do 
			visit registered_applications_path
			click_link("Create new registered application")
			expect(current_path).to eq(new_registered_application_path)
		end			
		it "saves the registered_application and show it's details" do
			fill_in('Name', with: 'New registered application name')
			fill_in('Url', with: 'New registered application name.com')
			click_button("Create Registered application")

			expect(current_path).to eq(registered_application_path(RegisteredApplication.last))
			expect(page).to have_content(RegisteredApplication.last.name)
			expect(page).to have_content(RegisteredApplication.last.url)
			expect(page).to have_content(" Registered Application was created successfully!")
			#save_and_open_page
		end
		it "associates the registered_application with the current_user" do 
			fill_in('Name', with: 'New name')
			fill_in('Url', with: 'New-url.com')
			click_button("Create Registered application")

			expect(RegisteredApplication.last.user.name).to eq(my_user.name)			
			#puts RegisteredApplication.last.user.name
			#puts my_user.name
		end
		it "does not save the registered_application if it has invalid attributes" do
			fill_in('Name', with: '')
			fill_in('Url', with: 'New-url.com')
			click_button("Create Registered application")

			expect(page).to_not have_content('New-url.com')
			expect(page).to have_content("There was an error saving the Registered Application. Please try again.")
		end
	end 	# Creating registered_application

	describe "Deleting registered_application" do
		it "removes the selected registered_application and shows the index page without the deleted item" do
			visit registered_application_path(my_registered_application)
			expect(page).to have_content(my_registered_application.name)
			click_link("Delete")
			expect(current_path).to eq(registered_applications_path)
			expect(page).to_not have_content(my_registered_application.name)
			expect(page).to have_content("Registered Application was deleted!")
			#save_and_open_page
		end
	end 	# Deleting registered_application

end 	# Registered Application








