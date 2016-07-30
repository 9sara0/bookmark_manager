feature "A user can sign in" do
  scenario "A registered used can login to his/her account" do
    sign_up
    sign_in
    expect(page).to have_content "Welcome, Sarah!"
  end
end
