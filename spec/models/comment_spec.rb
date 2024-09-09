require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "validations" do
    it { should validate_presence_of(:post_id) }
    it { should validate_presence_of(:discription) }
  end
  describe "association" do
    it { should have_many(:likes)}
  end

end
