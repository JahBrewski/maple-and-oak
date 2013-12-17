include ApplicationHelper

def sign_in(user, options={})
  visit new_user_session_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def valid_signup(user_type)
  fill_in "First name",             with: "Joel"
  fill_in "Last name",              with: "Brewer"
  fill_in "Email",                  with: "user@example.com"
  fill_in "Password",               with: "foobarfoobar"
  fill_in "Password confirmation",  with: "foobarfoobar"
  choose(user_type.capitalize)
end
