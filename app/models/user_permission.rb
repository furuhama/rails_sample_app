class UserPermission < ApplicationRecord
    belongs_to :user

    vaidates :user_id, presence: true
    validates :name, presence: true
end
