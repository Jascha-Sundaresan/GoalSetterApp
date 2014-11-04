require 'rails_helper'

feature "User has a show page" do
  before :each do
    sign_up
  end

  it "has a show page" do
    expect(page).to have_content "Fred"
  end
end