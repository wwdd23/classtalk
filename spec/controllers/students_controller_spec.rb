require 'spec_helper'

describe StudentsController do
  before(:each) do
    @current_user = login
  end
  
  describe "authorization" do
    pending "all actions should be accessible to logged in users" do
    end
    pending "no actions should be accessible to non-logged-in users" do
    end
  end

  describe "create_multiple" do

    it "adds multiple students to a group" do
      @group = FactoryGirl.create(:group)
      post :create_multiple, :group_id => @group.id, :group => {"students_attributes" => {"placeholder_name" => {"name"=>"TestName1", "phone_number"=>"5554443333", "email"=>"testname1@example.com", "_destroy"=>"false"}, "placeholder_name2" => {"name"=>"TestName2", "phone_number"=>"6665554444", "email"=>"testname2@example.com", "_destroy"=>"false"} } }
      @group.reload.students.count.should == 2
    end

    it "on success, should redirect to members_group_page" do
      @group = FactoryGirl.create(:group)
      post :create_multiple, :group_id => @group.id, :group => {"students_attributes" => {"placeholder_name" => {"name"=>"TestName1", "phone_number"=>"5554443333", "email"=>"testname1@example.com", "_destroy"=>"false"}, "placeholder_name2" => {"name"=>"TestName2", "phone_number"=>"6665554444", "email"=>"testname2@example.com", "_destroy"=>"false"} } }
      response.should redirect_to(members_group_path(@group))
    end

    it "on failure, should render the same page, with errors" do
      @group = FactoryGirl.create(:group)
      post :create_multiple, :group_id => @group.id, :group => {"students_attributes" => {"placeholder_name" => {"name"=>"TestName1", "phone_number"=>"555", "email"=>"testname1@example.com", "_destroy"=>"false"}, "placeholder_name2" => {"name"=>"TestName2", "phone_number"=>"6665554444", "email"=>"testname2@example.com", "_destroy"=>"false"} } }
      @group.reload.students.count.should == 0
      assigns[:group].errors.should_not be_empty
    end

  end
end
