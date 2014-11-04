
RSpec.configure do |config|

  config.expect_with :rspec do |expectations|

    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end


  config.mock_with :rspec do |mocks|

    mocks.verify_partial_doubles = true
  end


end

def sign_up(username='Fred', password='abcdef')
  visit new_user_url
  fill_in "Name", with: username
  fill_in "Password", with: password
  click_button 'Sign Up'
end

def sign_in(username='Fred', password='abcdef')
  visit new_session_url
  fill_in "Name", with: username
  fill_in "Password", with: password
  click_button 'Sign In'
end

def create_goal(title="TestGoal", description="nonsense")
  click_button "Create Goal"
  fill_in "Title", with: title
  fill_in "Description", with: description
  click_button 'Create New Goal'
end

def create_chester
  sign_up("Chester")
end

