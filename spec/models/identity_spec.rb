require 'spec_helper'

describe Identity do
  it "does not allow user to have duplicate identities" do
    user = create(:user)
    create(:identity, provider: "google_oauth2")
    identity = build(:identity, provider: "google_oauth2")

    expect(identity).to have(1).errors_on(:provider)
  end

end
