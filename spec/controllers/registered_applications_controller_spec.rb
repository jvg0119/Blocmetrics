# refactored original rspec spec

require 'rails_helper'

RSpec.describe RegisteredApplicationsController, type: :controller do
  let(:my_user) { create(:user, name: "Joe") }
  let(:another_user) { create(:user, name: "John") }
  let(:my_registered_application) { create(:registered_application, name: "testing123", user: my_user) }
  let(:another_registered_application) { create(:registered_application, name: "another", url: "another.com", user: another_user) }

  describe "User access" do
    before do
      # login_as(my_user, scope: :my_user) # does not work in the controller rspec tester
      my_user.confirm
      sign_in(my_user)
    end 

    describe "GET index" do
      before { get :index }  
      
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "assigns only current_user's Registered_Applications to @registered_applications" do
        expect(assigns(:registered_applications)).to eq([my_registered_application])
        expect(assigns(:registered_applications)).to_not eq([another_registered_application])
      end
    end   # GET index

    describe "GET show" do
      before { get :show, params: { id: my_registered_application.id } }
      
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "assigns the requested registration_application to @registered_application" do
        expect(assigns(:registered_application)).to eq(my_registered_application) 
      end
      it "renders the show view" do
        expect(response).to render_template(:show) 
      end
    end   # GET show

    describe "GET new" do
      before { get :new }
      
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "initializes @registered_application" do
        expect(assigns(:registered_application)).to be_a_new(RegisteredApplication) 
        expect(assigns(:registered_application)).to_not be_nil 
      end
      it "renders the new view" do
      expect(response).to render_template(:new) 
      end
    end   # GET #new   

    describe "GET edit" do
      before { get :edit, params: { id: my_registered_application.id } }
      
      it "returns http success" do   
        expect(response).to have_http_status(:success)
      end
      it "assigns the requested registration_application to @registered_application" do    
        expect(assigns(:registered_application)).to eq(my_registered_application)
      end
      it "renders the edit view" do 
        expect(response).to render_template :edit 
      end
    end   # GET #edit

    describe "POST create" do
      context "with valid attributes" do 
        it "increases the number of registered_application by 1" do
          expect { post :create, params: { registered_application: attributes_for(:registered_application) }
          }.to change(RegisteredApplication, :count).by(1)   #change { RegisteredApplication.count }.by(1)  # OK
        end

        it "increases the number of registered_application by 1 test#2" do
          expect { post :create, params: { registered_application: {name: "gosomething", url: "gosomething.com" } }
          }.to change(RegisteredApplication, :count).by(1)   
        end

        it "assigns the new registered_application to @registered_application" do 
          post :create, params: { registered_application: attributes_for(:registered_application, name: "New application name") }
          expect(assigns(:registered_application).name).to eq("New application name")
        end
        it "associates the new registered_application to the current_user" do
          post :create, params: { registered_application: attributes_for(:registered_application, ) } 
          expect(assigns(:registered_application).user.name).to eq(my_user.name)
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
      before { delete :destroy, params: { id: my_registered_application.id } }
      it "removes the registered_application" do
        expect(RegisteredApplication.last).to be_nil
        expect(RegisteredApplication.count).to eq(0) 
      end
      it "removes the registered_application 2" do
        expect(RegisteredApplication.last).to be_nil 
      end
      it "redirects to the registered_application index view" do
        expect(response).to redirect_to(registered_applications_path) 
      end 
    end   # DELETE destroy

  end   # User access

#=================================================================

  describe "Guest or unsigned user" do
    #let!(:responses) { expect(response).to redirect_to("/users/sign_in") }
    after { expect(response).to redirect_to("/users/sign_in") }

    describe "GET index" do
      before { get :index }  
      
      it "requires login" do
        expect(response).to have_http_status(302)
        #expect(response).to redirect_to("http://test.host/users/sign_in") # OK
        #expect(response).to redirect_to("/users/sign_in")
      end
    end   # GET index

    describe "GET show" do
      before { get :show, params: { id: my_registered_application.id } }
      
      it "requires login" do
      end
    end   # GET show

    describe "GET new" do
      before { get :new }
      
      it "requires login" do
      end
    end   # GET #new   

    describe "GET edit" do
      before { get :edit, params: { id: my_registered_application.id } }
      
      it "requires login" do   
      end
    end   # GET #edit

    describe "POST create" do
      it "requires login" do
        post :create, params: { registered_application: attributes_for(:registered_application) }   
      end
    end 

    describe "PUT update" do
      it "requires login" do
        put :update, params: { id: my_registered_application.id, registered_application: attributes_for(:registered_application) }   
      end
    end

    describe "DELETE destroy" do 
      it "requires login" do 
        my_registered_application
        delete :destroy, params: { id: my_registered_application.id }
      end
    end
  end   # Guest or unsigned user

end   # RegisteredApplicationsController





