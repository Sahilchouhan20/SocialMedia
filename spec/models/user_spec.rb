require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:bio) }
  end
  describe "association" do
    it { should have_many(:posts)}
    it { should have_many(:stories) }
    it { should have_many(:likes)}
    it { should have_many(:chats) }
    it { should have_many(:messages)}
    it { should have_many(:chat_users) }
  end
end
