require 'rails_helper'

RSpec.feature "Categories", type: :feature do
  let!(:product) { create(:product) }
  let!(:taxonomies) { create(:taxonomies) }
  let!(:taxon) { create(:taxon) }

  scenario "View category show page" do
    visit potepan_category_path(id: 1)
    expect(page).to have_link 'Home', href: potepan_index_path
  end
end
