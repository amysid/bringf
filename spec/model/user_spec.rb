require 'rails_helper'

RSpec.describe User, :type => :model do
  subject { described_class.new }
#   describe "Validations" do
#   it "is valid with valid attributes" do
#     expect(subject).to be_valid
#   end  
context "" do
    it "create user" do
      subject.first_name = "adam"
      subject.last_name = "gupta"
      subject.email = "adam@gmail.com"
      subject.password_digest = "password"
      expect(subject).to be_valid
    end
    it "is not valid without an first name" do
      subject.first_name = nil
      expect(subject).to_not be_valid
   end
   it "is not valid without an last name" do
      subject.last_name = nil
      expect(subject).to_not be_valid
   end
   it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
   end
 end
 describe "Associations" do
  it "has many laggages" do
    assc = described_class.reflect_on_association(:laggages)
    expect(assc.macro).to eq :has_many
  end
   
 end
end