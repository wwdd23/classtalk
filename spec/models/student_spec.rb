require 'spec_helper'

describe Student do
  before(:each) do
    @student = Factory.create(:student)
  end

  describe "their phone number" do
    it "must be 10 digits" do
      @student.phone_number.scan(/\d/).length.should == 10
    end
    it "must be in the canonical format" do
      @student.phone_number.should match(PhoneValidator::STORAGE_REGEX)
    end
    it "should automatically be converted to the canonical format, agnostic of valid-ish input" do
      Factory.create(:student, :phone_number=>"(555) 123-4567").phone_number.should == "5551234567"
    end
    it "may not be unique, across different groups" do
      FactoryGirl.build(:student,:phone_number=>@student.phone_number,:group_id=>3).should be_valid
    end
    it "must be unique in a group" do
      FactoryGirl.build(:student,:phone_number=>@student.phone_number,:group_id=>@student.group_id).should_not be_valid
    end

    it "may be blank, if and only if an email is present" do
      @student.phone_number = nil
      @student.email = nil
      @student.should_not be_valid
      @student.email = "student@company.com"
      @student.should be_valid
    end
  end

  describe "their name" do
    it "must be present" do
      FactoryGirl.build(:student,:name=>nil).should_not be_valid
    end
    it "can't be set to blank" do
      FactoryGirl.build(:student,:name=>"").should_not be_valid
    end
    it "might not be unique" do
      Factory.create(:student,:name=>@student.name).should be_valid
    end
  end
  describe "their group memberships" do
    pending "students can be members of no groups" do
    end
    pending "students can be members of exactly one group" do
    end
    pending "students can be members of multiple groups" do
    end
    pending "students can't be in the same group twice at the same time" do
    end
  end
end
