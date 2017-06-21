class Relationship < ApplicationRecord
  belongs_to :follower, class_name: Settings.relationship.class_name
  belongs_to :followed, class_name: Settings.relationship.class_name
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
