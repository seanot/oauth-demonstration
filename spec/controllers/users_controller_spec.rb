require 'spec_helper'

describe UsersController do

  describe 'GET#new' do
    it "assigns @user to be an instance of User" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the :new view" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST#create' do
    context "with valid attributes" do
      it "saves the new user to the database" do
        expect{
          post :create, user: attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it "assigns a session id"

      it "redirects the view to :root" do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to :root
      end
    end

    context "with invalid attributes" do
      it "does not save the user to the database" do
        expect{
          post :create, user: attributes_for(:invalid_user)
        }.to_not change(User, :count)
      end

      it " re-renders the :new view" do
        post :create, user: attributes_for(:invalid_user)
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET#edit' do
    it "assigns current_user to @user" do
      current_user = create(:user)
      get :edit, id: @user
      expect(assigns(current_user)).to eq @user
    end

    it "renders the :edit view" do
      current_user = create(:user)
      get :edit, id: @user
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH#update' do
    before :each do
      current_user = create(:user, name: "Sean O'Toole",
                            email: "sean@seanco.com")
    end

    context "valid attributes" do
      it "located the requested user" do
        patch :update, id: @user, user: attributes_for(:user)
        expect(assigns(:user)).to eq(@user)
      end

      it "changes user's attributes" do
        patch :update, id: @user,
        user: attributes_for(:user,
          name: "ST O'Toole", email: "sean@seanco.com")
        @user.reload
        expect(@user.name).to eq("ST O'Toole")
        expect(@user.email).to eq("sean@seanco.com")
      end

      it "redirects to :root" do
        patch :update, id: @user, user: attributes_for(:user)
        expect(response).to redirect_to :root
      end
    end
  end

  describe 'DELETE#destroy' do
    before :each do
      @user = create(:user)
    end

    it "deletes the contact" do
      expect{
        delete :destroy, id: @user
      }.to change(User, :count).by(-1)
    end

    it "deletes the associated identities"
    it "redirects to :root" do
      delete :destroy, id: @user
      expect(response).to redirect_to :root
    end
  end
end
