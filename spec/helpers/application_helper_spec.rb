require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "Application Title helpers" do
    it "Title is displayed" do
      expect(full_title("test")).to eq "test - BIGBAG Store"
      expect(full_title("")).to eq "BIGBAG Store"
    end

    it "heading displayed" do
      expect(heading_title("test-caregory")).to eq ["test-caregory"]
      expect(heading_title("test-category/clothing/shirts")).
        to eq ["test-category", "clothing", "shirts"]
      expect(heading_title("")).to eq [""]
    end
  end
end
