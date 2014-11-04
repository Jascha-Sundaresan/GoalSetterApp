require 'rails_helper'

feature "the signup process" do
  before :each do
    visit 'users/new'
  end

  it "has a new user page" do
    expect(page).to have_content "Sign Up"
  end

  it "takes a name and password" do
    expect(page).to have_content "Name"
    expect(page).to have_content "Password"
  end

  it "validates presence of name" do
    sign_up("")
    expect(page).to have_content "Name can't be blank"
  end

  it "rejects blank password" do
    sign_up('Fred', "")
    expect(page).to have_content "Password is too short"
  end

  it "rejects password with length less than 6" do
    sign_up('Fred', "poo")
    expect(page).to have_content "Password is too short"
  end

  feature "signing up a user" do
    before :each do
      sign_up("Fred")
    end

    it "shows username on the homepage after signup" do
      expect(page).to have_content "Fred"
    end

    it "should display a button for log out" do
      expect(page).to have_button "Log Out"
    end

  end

end

feature "logging out" do
  before :each do
    visit 'users/new'
  end

  it "begins with logged out state" do
    expect(page).to_not have_content "Log Out"
  end


  it "doesn't show username on the homepage after logout" do
    sign_up
    click_button "Log Out"
    expect(page).to_not have_content "Fred"
  end

end

feature "logging in" do
  before :each do
    visit 'session/new'
  end

  it "has a user log in page" do
    expect(page).to have_content "Sign In"
  end

  it "takes a name and password" do
    expect(page).to have_content "Name"
    expect(page).to have_content "Password"
  end

  it "rejects incorrect user/password combination" do
    sign_up
    click_button "Log Out"
    sign_in("", "abc")
    expect(page).to have_content "Sign In"
  end

  it "shows username on the homepage after login" do
    sign_up
    click_button "Log Out"
    sign_in
    expect(page).to have_content "Fred"
  end

end
