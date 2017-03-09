class UsersController < ApplicationController

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:notice] = "User name was updated successfully!"
			redirect_to edit_user_registration_path 
		else
			flash[:error] = "There was an error updating your account. Please try again."
			redirect_to edit_user_registration_path
		end			
	end

	private
	def user_params
		params.require(:user).permit(:name)
	end

end
