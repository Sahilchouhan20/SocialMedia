require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:text) }
  end
  describe "association" do
    it { should have_many(:comments)}
    it { should have_many(:likes) }
  end
end
