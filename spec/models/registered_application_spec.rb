require 'rails_helper'

RSpec.describe RegisteredApplication, type: :model do
  #let(:user) { create(:user) }
  #let(:registered_application) { create(:registered_application) }

  it { should belong_to :user }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:url) }
  it { should validate_uniqueness_of(:url) }

end
