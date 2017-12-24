class UserPermission < ApplicationRecord
    belongs_to :user

    validates :user_id, presence: true
    validates :name, presence: true

    scope :name_list, -> { pluck(:name) }
end
