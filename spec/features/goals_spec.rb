require 'rails_helper'

feature "user crud architecture for goals" do
  before :each do
    sign_up
    user = User.find_by(name: 'Fred')
  end

  it "has 'create goal' button on user page" do
    expect(page).to have_button 'Create Goal'
  end

  it "navigates to 'create goal' page upon button press" do
    click_button 'Create Goal'
    expect(page).to have_content 'New Goal'
  end

  feature "user can create goal" do
    before :each do
      click_button 'Create Goal'
    end

    it "has a title and description" do
      expect(page).to have_content 'Title'
      expect(page).to have_content 'Description'
    end

    it "rejects a goal without a title" do
      fill_in "Title", with: ""
      fill_in "Description", with: "nonsense"
      click_button 'Create New Goal'
      expect(page).to have_content "Title can't be blank"
    end

    it "rejects a goal without a description" do
      fill_in "Title", with: "TestGoal"
      fill_in "Description", with: ""
      click_button 'Create New Goal'
      expect(page).to have_content "Description can't be blank"
    end

    it "displays goal on user show page upon sucessful entry" do
      fill_in "Title", with: "TestGoal"
      fill_in "Description", with: "nonsense"
      click_button 'Create New Goal'
      expect(page).to have_content 'TestGoal'
      expect(page).to have_content "nonsense"
    end


  end

  feature "user can update goal" do
    before :each do
      create_goal
    end

    it "has a edit goal button" do
      expect(page).to have_button "Edit Goal"
    end

    it "goes to edit form on button press" do
      click_button "Edit Goal"
      expect(page).to have_content "Edit Your Goal!"
    end

    it "rejects a goal without a title" do
      click_button "Edit Goal"
      fill_in "Title", with: ""
      fill_in "Description", with: "nonsense"
      click_button 'Update Goal'
      expect(page).to have_content "Title can't be blank"
    end

    it "rejects a goal without a description" do
      click_button "Edit Goal"
      fill_in "Title", with: "TestGoal"
      fill_in "Description", with: ""
      click_button 'Update Goal'
      expect(page).to have_content "Description can't be blank"
    end

    it "shows user page upon successful update" do
      click_button "Edit Goal"
      fill_in "Title", with: "TestGoal2"
      fill_in "Description", with: "more nonsense"
      click_button 'Update Goal'
      expect(page).to have_content "more nonsense"
    end
  end


  feature "user can delete goal" do
    before :each do
      create_goal
    end

    it "shows delete button" do
      expect(page).to have_button "Delete"
    end

    it "successfully deletes goal" do
      click_button "Delete"
      expect(page).to_not have_content "TestGoal"
    end
  end

end

feature "goals can be private or public" do

  before :each do
    sign_up
    create_goal
    click_button "Log Out"
    create_chester
    create_goal("PublicGoal")
  end

  it "allows a user to set a goal to public" do
    expect(page).to have_button "Make Public"
  end

  it "makes goal public" do
    click_button "Make Public"
    expect(page).to have_button "Make Private"
  end


  feature "user can't see others' private goals" do

    it "does not allow another user to see a user's private goals" do
      visit user_url(1)
      expect(page).to_not have_content "TestGoal"
    end

  end

  feature "user can see all public goals" do
    before :each do
      click_button "Make Public"
      click_button "Log Out"
      sign_in
    end

    it "allows user's to see others public goals" do
      visit 'users/2'
      expect(page).to have_content "PublicGoal"
    end


  end


end

feature "user can keep track of completion of goals" do
  before :each do
    sign_up
    create_goal
  end

  feature "user can mark goals as complete" do

    it "defaults to incomplete" do
      expect(page).to_not have_content "Complete!"
    end

    it "displays button to mark completed" do
      expect(page).to have_button "Completed"
    end

    it "allows project to be marked complete" do
      click_button "Completed"
      expect(page).to have_content "Complete!"
    end

  end

end

