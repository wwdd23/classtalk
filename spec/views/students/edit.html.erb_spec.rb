require 'spec_helper'

describe "students/edit.html.erb" do
  before(:each) do
    @student = assign(:student, stub_model(Student))
    @group = assign(:group, Factory.create(:group))
  end

  it "renders the edit student form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => group_students_path(@group,@student), :method => "post" do
    end
  end
end
