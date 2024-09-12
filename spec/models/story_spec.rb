require 'rails_helper'

RSpec.describe Story, type: :model do
  describe "association" do
    it { should have_many(:likes)}
  end
  describe ".remove_expired" do
    let!(:recent_story) { create(:story, created_at: 1.hour.ago) }
    let!(:expired_story) { create(:story, created_at: 2.days.ago) }

    it "removes stories older than 24 hours" do
      expect {
        Story.remove_expired
      }.to change { Story.count }.by(-1)  # Expect the count to decrease by 1

      expect(Story.exists?(expired_story.id)).to be_falsey
      expect(Story.exists?(recent_story.id)).to be_truthy
    end
  end
end
