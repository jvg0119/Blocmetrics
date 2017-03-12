require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should belong_to :registered_application }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end

