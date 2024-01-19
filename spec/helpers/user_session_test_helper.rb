module UserSessionTestHelper
  def sign_in_as(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:google_oauth2, uid: @user.google_id, info: {first_name: @user.first_name, last_name: @user.last_name, email: @user.email}, credentials: {token: @user.google_token})

    visit sign_in_index_path
    click_button "Google Sign In"
    visit sessions_create_path
  end
end