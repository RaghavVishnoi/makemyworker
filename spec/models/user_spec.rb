require 'rails_helper'

describe User, :type => :model do

  context "valid Factory" do
    it "has a valid factory" do
      expect(FactoryGirl.build(:user)).to be_valid
    end
  end

  context "validations" do
    before { create(:user) }

    context "presence" do
      it { should validate_presence_of :first_name }
      it { should validate_presence_of :last_name }
      # it { should validate_presence_of :email }
      # it { should validate_presence_of :birthday }
      # it { should validate_presence_of :gender }
      it { should validate_presence_of :facebook_user_id }
      it { should validate_presence_of :facebook_user_token }
    end

    context "uniqueness" do
      it { should validate_uniqueness_of :facebook_user_id }
      it { should validate_uniqueness_of :facebook_user_token }
      it { should validate_uniqueness_of :token }
    end
  end
end
