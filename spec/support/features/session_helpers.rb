module Features
  module SessionHelpers
    def sign_up(user_type)
      user = FactoryGirl.create(:user, user_type)
      sign_in user
    end
  end
end
