
require 'rails_helper'

describe UsersController, :type => :controller do 
	
	before do
		@user = FactoryGirl.create(:user)
		@user2 = User.create!(email: "rspecuser2@test.com", password: "1234567")
	end
	
	describe "GET #show" do
		context 'User is logged in' do
			before do
				sign_in @user
			it 'loads correct user details' do
				get :show, params: {id: @user.id}
				expect(response).to have_http_status(200)
				expect(assigns(:user)).to eq @user
        	end
      	end
	
		context 'No user is logged in' do
			it 'redirects to login' do
				get :show, params: {id: @user.id}
         		expect(response).to be_successful
          		redirect_to(root_path)
        	end
      	end
      	context 'User not authorized' do
      		before do
      			sign_in @user
      		end
      		it 'redirects to root path' do
      	  		get :show, params: {id: @user2.id}  
				expect(response).to redirect_to(root_path)
        	end
      	end
	end
end