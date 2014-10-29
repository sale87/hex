require 'spec_helper'

describe User do
  before do
    @user = FactoryGirl.build(:user)
  end

  it "gets a uid assigned" do
    @user.save!
    expect(@user.uid).not_to be_blank
  end

  it "doesn't send a confirmation email" do
    expect { @user.save! }.not_to change { ActionMailer::Base.deliveries.count }
  end

  it "has to have valid email" do
    @user.email = ''
    expect(@user).not_to be_valid

    @user.email = 'a'
    expect(@user).not_to be_valid
  end
end
