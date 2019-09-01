require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'association' do
    describe 'has_many' do
      it { should have_many(:emails).dependent(:destroy) }
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'bulk_insert' do
    # users_controller_spec.rb
  end
end
