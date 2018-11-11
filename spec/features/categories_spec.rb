require 'rails_helper'

RSpec.feature "Categories", type: :feature do
  scenario "View category show page" do
    visit potepan_category_path(id: 1)
    expect(page).to have_link 'Home', href: potepan_index_path
  end
end
