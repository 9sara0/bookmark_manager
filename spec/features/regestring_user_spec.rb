feature "Users sign-up" do
  scenario "user register an account/users count increases by 1" do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content "Welcome, David!"
    expect(User.first.email).to eq "David@mail.com"
  end

  scenario "no user created with mismatching password and password confirmation" do

    expect { sign_up(password_confirmation: 'worng') }.not_to change(User, :count)
    expect(current_path).to eq '/users'
    expect(page).to have_content("Password does not match the confirmation")
  end

  scenario "User can't sign up without an email address" do
    expect { sign_up(email: nil) }.not_to change(User, :count)
  end

  scenario "User can't sign up with an invalid email address" do
    expect { sign_up(email: "invalid@email") }.not_to change(User, :count)
    expect(page).to have_content('Email has an invalid format')
  end

  scenario 'A User can must sign up with a unique email' do
    sign_up
    expect { sign_up }.to_not change(User, :count)
    expect(page).to have_content('Email is already taken')
  end
end
