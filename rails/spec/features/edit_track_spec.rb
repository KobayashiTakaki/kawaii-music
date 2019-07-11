require "rails_helper"
RSpec.feature "edit track" do
  let!(:user) { create(:user) }
  let!(:track) { create(:track) }

  context "user logged in" do
    background do
      visit admin_login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: "password"
      click_button "Log in"
    end

    scenario "add/delete genre on track" do
      visit edit_admin_track_path(track.sc_id)
      fill_in "genre[name]", with: "new genre"
      click_button "add genre"
      new_genre = Genre.find_by(name: "new genre")
      expect(track.genres).to include(new_genre)
      click_link "x", href: admin_track_genre_path(track, new_genre)
      expect(track.genres).not_to include(new_genre)
    end

    scenario "add/delete category on track" do
      visit edit_admin_track_path(track.sc_id)
      fill_in "category[name]", with: "new category"
      click_button "add category"
      new_category = Category.find_by(name: "new category")
      expect(track.categories).to include(new_category)
      click_link "x", href: admin_track_category_path(track, new_category)
      expect(track.categories).not_to include(new_category)
    end
  end
end
