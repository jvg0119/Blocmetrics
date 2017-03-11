# original rspec spec
# removed the .spec

require 'rails_helper'

RSpec.describe RegisteredApplicationsController, type: :controller do
  let(:my_user) { create(:user) }
  let(:my_registered_application) { create(:registered_application, user: my_user, name: "testing123") }

  describe "GET index" do  
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns Registered_Application.all to @registered_applications" do
      #registered_application
      get :index
      expect(assigns(:registered_applications)).to eq([my_registered_application])
      #puts registered_application.inspect
    end
  end   # GET index

  describe "GET show" do
    it "returns http success" do
      get :show, params: { id: my_registered_application.id }
      expect(response).to have_http_status(:success)
    end
    it "assigns the requested registration_application to @registered_application" do
      get :show, params: { id: my_registered_application.id }
      expect(assigns(:registered_application)).to eq(my_registered_application) 
    end
    it "renders the show view" do
      get :show, params: { id: my_registered_application.id }
      expect(response).to render_template(:show) 
    end
  end   # GET show

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "initializes @registered_application" do
      get :new
      expect(assigns(:registered_application)).to be_a_new(RegisteredApplication) 
      expect(assigns(:registered_application)).to_not be_nil 
    end
    it "renders the new view" do
    get :new
    expect(response).to render_template(:new) 
    end
  end   # GET #new   

  describe "GET edit" do
    it "returns http success" do
      get :edit, params: { id: my_registered_application.id }
      expect(response).to have_http_status(:success)
    end
    it "assigns the requested registration_application to @registered_application" do 
      get :edit, params: { id: my_registered_application }
      expect(assigns(:registered_application)).to eq(my_registered_application)
    end
    it "renders the edit view" do 
      get :edit, params: { id: my_registered_application.id }
      expect(response).to render_template :edit 
    end
  end   # GET #edit

  describe "POST create" do
    context "with valid attributes" do 
      it "increases the number of registered_application by 1" do
        #post :create, params: { registered_application: { name: "name999", url: "bingo", user: my_user } } # OK
        #post :create, params: { registered_application: attributes_for(:registered_application, name: "new name")}
        #puts RegisteredApplication.last.name
        expect { post :create, params: { registered_application: attributes_for(:registered_application) }
        }.to change(RegisteredApplication, :count).by(1)   #change { RegisteredApplication.count }.by(1)  # OK
      end
      it "assigns the new registered_application to @registered_application" do 
        post :create, params: { registered_application: attributes_for(:registered_application, name: "New application name") }
        expect(assigns(:registered_application).name).to eq("New application name")
      end
      it "redirects to the new registered_application (@registered_application)" do
        post :create, params: { registered_application: attributes_for(:registered_application) }
        expect(response).to redirect_to(RegisteredApplication.last) 
      end
    end
    context "with invalid attributes" do 
      it "does not increase the number of registered_application" do
        expect{ post :create, params: { registered_application: attributes_for(:registered_application, name: '') }
        }.to_not change { RegisteredApplication.count }
        expect { post :create, params: { registered_application: { name: nil, } } }
      end
      it "re-renders the new view" do
        post :create, params: { registered_application: { name: nil, url: "my url" } }
        expect(response).to render_template(:new) 
      end
    end   # with valid attributes  
  end   # POST create

  describe "PUT update" do
    context "with valid attributes" do 
      it "updates registered_application with the expected attributes" do
        put :update, params: { id: my_registered_application.id, registered_application: attributes_for(:registered_application, name: "new registered_application name") }
        expect(assigns(:registered_application).name).to eq("new registered_application name") 
        expect(assigns(:registered_application).name).to_not eq(my_registered_application.name) # old name
      end
      it "redirects to the updated registered_application (@registered_application)" do
        put :update, params: { id: my_registered_application, registered_application: { name: "test123", url: "testurl", user: my_user } } 
        expect(response).to redirect_to(my_registered_application) # show page
        expect(response).to redirect_to(registered_application_path my_registered_application) # show page
      end
    end
    context "with invalid attributes" do 
      it "does not updates registered_application" do
        put :update, params: { id: my_registered_application, registered_application: attributes_for(:registered_application, name: "invalid name", url: nil ) }
        expect(RegisteredApplication.last.name).to_not eq("invalid name" )
      end
      it "re-renders the edit view" do 
        put :update, params: { id: my_registered_application, registered_application: attributes_for(:registered_application, name: nil ) }
        expect(response).to render_template(:edit)
      end
    end   # with valid attributes  
  end   # PUT update

  describe "DELETE destroy" do
    it "removes the registered_application" do
      delete :destroy, params: { id: my_registered_application.id }
      expect(RegisteredApplication.last).to be_nil
      expect(RegisteredApplication.count).to eq(0) 
    end
    it "removes the registered_application 2" do

      delete :destroy, params: { id: my_registered_application.id }
      expect(RegisteredApplication.last).to be_nil 
    end
    it "redirects to the registered_application index view" do
      delete :destroy, params: { id: my_registered_application.id }
      expect(response).to redirect_to(registered_applications_path) 
    end 
  end   # DELETE destroy
 
end   # RegisteredApplicationsController

