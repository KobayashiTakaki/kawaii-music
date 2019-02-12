require "rails_helper"
RSpec.feature "admin pages" do
  context "user not logged in" do
    scenario "user visits admin pages" do
      visit admin_root_path
      expect(page).to have_current_path(root_path)
      visit admin_tracks_path
      expect(page).to have_current_path(root_path)
      visit edit_admin_track_path(1)
      expect(page).to have_current_path(root_path)
      visit admin_genres_path
      expect(page).to have_current_path(root_path)
      visit admin_genre_path(1)
      expect(page).to have_current_path(root_path)
      visit admin_tags_path
      expect(page).to have_current_path(root_path)
      visit admin_tag_path(1)
      expect(page).to have_current_path(root_path)
    end
  end
end
