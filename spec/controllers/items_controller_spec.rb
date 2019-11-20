require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  describe "items#destroy action" do
    it "should allow a user to destroy items" do
      item = FactoryBot.create(:item)
      delete :destroy, params: { id: item.id }
      expect(response).to redirect_to root_path
      item = Item.find_by_id(item.id)
      expect(item).to eq nil
    end

    it "should return a 404 message if we cannot find a item with the id that is specified" do
      delete :destroy, params: { id: 'TRY 4' }
      expect(response).to have_http_status(:not_found)
    end
  end
  describe "items#update action" do
    it "should allow users to successfully update items" do
      item = FactoryBot.create(:item, title: "Initial Value")
      patch :update, params: { id: item.id, item: { title: 'Changed' } }
      expect(response).to redirect_to root_path
      item.reload
      expect(item.title).to eq "Changed"
    end

    it "should have http 404 error if the item cannot be found" do
      patch :update, params: { id: "TRY 3", item: { title: 'Changed' } }
      expect(response).to have_http_status(:not_found)
    end

    it "should render the edit form with an http status of unprocessable_entity" do
      item = FactoryBot.create(:item, title: "Initial Value")
      patch :update, params: { id: item.id, item: { title: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      item.reload
      expect(item.title).to eq "Initial Value"
    end
  end

  describe "items#edit action" do
    it "should successfully show the edit form if the item is found" do
      item = FactoryBot.create(:item)
      get :edit, params: { id: item.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error message if the item is not found" do
      get :edit, params: { id: 'TRY 1' }
      expect(response).to have_http_status(:not_found)
    end
  end




  describe "items#show action" do
    it "should successfully show the page if the item is found" do
      item = FactoryBot.create(:item)
      get :show, params: { id: item.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error if the item is not found" do
      get :show, params: { id: 'TRY 2' }
      expect(response).to have_http_status(:not_found)
    end
  end




  describe "items#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "items#new action" do
    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show the new form" do
      user = FactoryBot.create(:user)
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "items#create action" do
    it "should require users to be logged in" do
      post :create, params: { item: { title: "Hello" } }
      expect(response).to redirect_to new_user_session_path
    end


    it "should successfully create a new item in our database" do
      user = FactoryBot.create(:user)
      sign_in user


      post :create, params: { item: { title: 'Hello!' } }
      expect(response).to redirect_to root_path

      item = Item.last
      expect(item.title).to eq("Hello!")
      expect(item.user).to eq(user)

    end

    it "should properly deal with validation errors" do
      user = FactoryBot.create(:user)
      sign_in user


      post :create, params: { item: { title: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Item.count).to eq Item.count
    end
  end

end
