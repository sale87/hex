class Game < ActiveRecord::Base
  validates :creator_id, presence: true, numericality: { only_integer: true }
end
