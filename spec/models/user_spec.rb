require 'rails_helper'

RSpec.describe User, type: :model do
  #let(:user) { create(:user) }
  #let(:registered_application) { create(:registered_application) }

  it { should have_many :registered_applications }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }


end


