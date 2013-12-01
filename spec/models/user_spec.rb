require 'spec_helper'

describe User do
  it "has a valid factory" do
    expect(create(:user)).to be_valid
  end

  it "is invalid without email address" do
    user = build(:user, email: nil)
    expect(user).to have(1).errors_on(:email)
  end

  it "is invalid with a duplicate email address" do
    create(:user, email: "sean@seanco.com")
    user = build(:user, email: "sean@seanco.com")
    expect(user).to have(1).errors_on(:email)
  end


  # describe ".find or create with omniauth" do
  #   before :each do
  #     auth = ''
  #     info = ''
  #     name = "Sean O'Toole"
  #     email = "sean@seanco.com"
  #     @user = User.create(name: auth.info.name,
  #                         email: auth.info.email)
  #   end

  #   it "matches database name with oauth name" do
  #     expect(@user.name).to eq "Sean O'Toole"
  #   end

  #   it "matches database email with oauth email"
  # end
end
