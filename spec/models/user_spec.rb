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

  it "matches database name with oauth name"
  it "matches database email with oauth email"

end
