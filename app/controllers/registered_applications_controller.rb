class RegisteredApplicationsController < ApplicationController
	before_action :set_registered_application, except: [:index, :new, :create]
	before_action :authenticate_user!

  def index
  	@registered_applications = RegisteredApplication.where(user: current_user)
  end

  def show
  	#@registered_application = RegisteredApplication.find(params[:id])
    @events = @registered_application.events.group_by(&:name).sort
  end

  def new
  	@registered_application = RegisteredApplication.new
  end

  def edit
  	#@registered_application = RegisteredApplication.find(params[:id])
  end

  def create
  	@registered_application = RegisteredApplication.new(registered_application_params)
  	@registered_application.user = current_user
  	if @registered_application.save
  		flash[:notice] = "Registered Application was created successfully!"
  		redirect_to @registered_application 
  	else
  		flash[:error] = "There was an error saving the Registered Application. Please try again."
  		render :new
  	end
  end

  def update
  	#@registered_application = RegisteredApplication.find(params[:id])
  	if @registered_application.update_attributes(registered_application_params)
  		flash[:notice] = "Registered Application was updated successfully!"
  		redirect_to @registered_application
  	else
  		flash[:error] = "There was an error updating the Registered Application. Please try again."
  		render :edit
  	end
  end

  def destroy
  	#@registered_application = RegisteredApplication.find(params[:id])
  	if @registered_application.destroy
  		flash[:notice] = "Registered Application was deleted!"
  		redirect_to registered_applications_path
  	else
  		flash[:error] = "There was an error deleting the Registered Application. Please try again."
  		render @registered_application
  	end
  end

private 
	def registered_application_params 
		params.require(:registered_application).permit(:name)
	end

	def set_registered_application
		@registered_application = RegisteredApplication.find(params[:id])
	end  

end
