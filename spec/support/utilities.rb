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
  fill_in "Username",               with: "jbrewski"
  fill_in "Email",                  with: "user@example.com"
  fill_in "Password",               with: "foobarfoobar"
  fill_in "Password confirmation",  with: "foobarfoobar"
  choose(user_type.capitalize)
end

def project_text_fields
   { 
   project_company_name: "Jay's Cookies",
   project_contact_name: "Jay Z",
   project_city: "Birmingham",
   project_contact_email_address: "jay@z.com",
   project_contact_phone_number: "123-456-7890",
   project_short_description: "I will bake delicious cookies.",
   project_long_description: "I will bake the best cookies in the entire world. The entire universe will ingest my creations and become better because of them. One day my cookies might just take over the world. Consider yourself forewarned.",
   project_user_current_position: "Head Chef/Owner at Bluebird Cafe",
   project_user_highest_position: "Head Chef/Owner at Bluebird Cafe",
   project_user_current_restaurant_owner: "Yes, I own/operate Bluebird Cafe",
   project_user_previous_restaurant_owner: "Yes, I own/operate Bluebird Cafe",
  }
end

def project_select_fields
  {
   "project[state]" => {"AL" => "Alabama" },
   "project[category]" => {"Cookie stores" => "cookie store" },
   "project_sub_category" => {"Start up restaurant" => "startup" },
   "project[user_hospitality_experience]" => {"2-5" => "2-5" },
   "project[user_management_experience]" => {"2-5" => "2-5" }
  }
end

def fill_in_project_fields

  project_text_fields.each do |key, value|
   fill_in key, with: value
  end

  project_select_fields.each do |key, value|
   select value.inject.first, from: key
  end
end


def valid_card_data
  exp_date = 3.months.from_now
  {
    number:               '4242424242424242',
    cvc:                  '123',
    address_zip:          '12312',
    exp_month:            exp_date.month,
    exp_year:             exp_date.year
  }
end
