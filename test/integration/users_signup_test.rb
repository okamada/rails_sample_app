require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { 
        name:                   "",
        email:                  "user@invalid",
        password:               "foo",
        password_confirmation:  "bar" 
        }
      }
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'

    # assert error messages
    assert_select 'div#error_explanation' do 
      assert_select 'div.alert-danger'
    end
  end

  test "valid signup information" do
    assert_difference 'User.count', 1 do
      post users_path, params: { user: {
        name:                   "Valid User",
        email:                  "user@example.com",
        password:               "password",
        password_confirmation:  "password"
        }
      }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not  flash[:error]
    assert      flash[:success], "Welcome to the Sample App!"
    assert is_logged_in?
  end
end
