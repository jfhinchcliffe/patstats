require 'rails_helper'
require 'capybara/rspec'

RSpec.describe PagesController, type: :controller do
  

  describe "on GET to /committee-members" do
    before { get :index }

    it "responds with success and render template" do
      expect(response).to be_success
      expect(response).to render_template("index")
    end
  end


end
