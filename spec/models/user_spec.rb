require 'spec_helper'

describe User do
  it "is valid with a name, email and password" do
    user = User.new(name: "Sean O'Toole",
                    email: 'sean@seanco.com',
                    password: "password",
                    password_confirmation: "password")

    expect(user).to be_valid
  end

  it "is invalid without email address" do
    expect(User.new(email: nil)).to have(1).errors_on(:email)
  end

  it "is invalid with a duplicate email address" do
    User.create(name: "Sean O'Toole",
                email: 'sean@seanco.com',
                password: "password",
                password_confirmation: "password")
    user = User.new(name: "Thomas O'Toole",
                    email: "sean@seanco.com",
                    password: "password",
                    password_confirmation: "password")

    expect(user).to have(1).errors_on(:email)
  end
end
