require 'rails_helper'

RSpec.describe "stops/show", type: :view do
  before(:each) do
    @stop = assign(:stop, Stop.create!(
      :routes_serviced => "Routes Serviced",
      :stop_name => "Stop Name",
      :operator => "Operator",
      :diva_id => "Diva",
      :mode => 2,
      :currently_checked => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Routes Serviced/)
    expect(rendered).to match(/Stop Name/)
    expect(rendered).to match(/Operator/)
    expect(rendered).to match(/Diva/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/false/)
  end
end
