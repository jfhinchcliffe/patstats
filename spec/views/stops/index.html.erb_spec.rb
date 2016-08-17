require 'rails_helper'

RSpec.describe "stops/index", type: :view do
  before(:each) do
    assign(:stops, [
      Stop.create!(
        :routes_serviced => "Routes Serviced",
        :stop_name => "Stop Name",
        :operator => "Operator",
        :diva_id => "Diva",
        :mode => 2,
        :currently_checked => false
      ),
      Stop.create!(
        :routes_serviced => "Routes Serviced",
        :stop_name => "Stop Name",
        :operator => "Operator",
        :diva_id => "Diva",
        :mode => 2,
        :currently_checked => false
      )
    ])
  end

  it "renders a list of stops" do
    render
    assert_select "tr>td", :text => "Routes Serviced".to_s, :count => 2
    assert_select "tr>td", :text => "Stop Name".to_s, :count => 2
    assert_select "tr>td", :text => "Operator".to_s, :count => 2
    assert_select "tr>td", :text => "Diva".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
