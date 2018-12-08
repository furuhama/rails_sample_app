class UserPermission < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  # 現在権限は admin maintainer のみ
  validates :name, inclusion: { in: %w(admin maintainer) }

  scope :name_list, -> { pluck(:name) }
end
