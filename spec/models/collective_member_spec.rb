require 'rails_helper'

RSpec.describe CollectiveMember, type: :model do
  do "it should have a valid factory" do
    member = FactoryGirl.create(:collective_member)
  end
end
