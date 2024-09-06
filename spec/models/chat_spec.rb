require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe "association" do
    it { should have_many(:chat_users)}
    it { should have_many(:messages)}
    it { should have_many(:users)}
  end
end
