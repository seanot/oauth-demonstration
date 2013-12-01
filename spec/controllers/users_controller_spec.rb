require 'spec_helper'

describe UsersController do

  describe 'GET#new' do
    it "assigns @user to be an instance of User"
    it "renders the :new view"
  end

  describe 'POST#create' do
    context "with valid attributes" do
      it "saves the new user to the database"
      it "assigns a session id"
      it "redirects the view to :root"
    end

    context "with invalid attributes" do
      it "does not save the user to the database"
      it " re-renders the :new view"
    end
  end

  describe 'GET#edit' do
    it "assigns current_user to @user"
    it "renders the :edit view"
  end

  describe 'PUT#update' do
    it "changes user's attributes"
    it "redirects to :root"
  end

  describe 'DELETE#destroy' do
    it "deletes the contact"
    it "deletes the associated identities"
    it "redirects to :root"
  end
end
