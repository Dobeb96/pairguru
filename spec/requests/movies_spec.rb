require "rails_helper"

describe "Movies requests", type: :request do
  describe "movies list" do
    it "displays right title" do
      visit "/movies"
      expect(page).to have_selector("h1", text: "Movies")
    end
  end

  describe "movies json" do
    it "displays movies" do
      visit "/movies.json"
      expect(page.body).to include('movies')
    end

    it "displays genres" do
      visit "/movies.json?genres=true"
      expect(page.body).to include('genres')
    end
  end
end
