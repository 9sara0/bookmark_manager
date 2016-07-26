feature 'Filter Tags' do
  scenario 'User can filter links by their tags' do
    visit '/links/new'
    fill_in "Title", with: "Makers Academy"
    fill_in "URL", with: "http://www.makersacademy.com"
    fill_in "tags", with: "code"
    click_button "Add"
    visit '/links/new'
    fill_in "Title", with: "Github"
    fill_in "URL", with: "http://www.github.com"
    fill_in "tags", with: "bubbles"
    click_button "Add"

    visit '/tags/bubbles'
    expect(page).to have_content('Github')
    expect(page).not_to have_content('Makers Academy')
  end
end
