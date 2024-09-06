require 'rails_helper'

RSpec.describe Story, type: :model do
  describe "association" do
    it { should have_many(:likes)}
  end
end
