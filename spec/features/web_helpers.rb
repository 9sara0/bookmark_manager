def visit_and_fill
  visit '/links/new'
  fill_in :title, with: "Google"
  fill_in :url, with: "www.google.com"
end

def add_tag
  fill_in(:tag, with: "search engine")
end


def sign_up(password: password = 12, email: email = "David@mail.com", password_confirmation: password_confirmation = 12)
  visit '/users/new'
  fill_in :user_name, with:             "David"
  fill_in :password, with:              password
  fill_in :email, with:                 email
  fill_in :password_confirmation, with: password_confirmation
  click_button "Register"
end
