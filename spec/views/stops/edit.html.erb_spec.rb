require 'rails_helper'

RSpec.describe "stops/edit", type: :view do
  before(:each) do
    @stop = assign(:stop, Stop.create!(
      :routes_serviced => "MyString",
      :stop_name => "MyString",
      :operator => "MyString",
      :diva_id => "MyString",
      :mode => 1,
      :currently_checked => false
    ))
  end

  it "renders the edit stop form" do
    render

    assert_select "form[action=?][method=?]", stop_path(@stop), "post" do

      assert_select "input#stop_routes_serviced[name=?]", "stop[routes_serviced]"

      assert_select "input#stop_stop_name[name=?]", "stop[stop_name]"

      assert_select "input#stop_operator[name=?]", "stop[operator]"

      assert_select "input#stop_diva_id[name=?]", "stop[diva_id]"

      assert_select "input#stop_mode[name=?]", "stop[mode]"

      assert_select "input#stop_currently_checked[name=?]", "stop[currently_checked]"
    end
  end
end
