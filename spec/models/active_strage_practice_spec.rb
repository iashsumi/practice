require 'rails_helper'

RSpec.describe ActiveStragePractice, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
