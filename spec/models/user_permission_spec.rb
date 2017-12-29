require 'rails_helper'

RSpec.describe UserPermission, type: :model do
#   describe 'Associations' do
#     it { is_expected.to belong_to(:user) }
#   end

  describe 'Validations' do
    describe 'name' do
      it { is_expected.to validate_inclusion_of(:name).in_array(%w(admin maintainer)) }
    end
  end
end
