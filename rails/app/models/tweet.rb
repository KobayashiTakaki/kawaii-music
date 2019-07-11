class Tweet < ApplicationRecord
  scope :not_posted, -> { where(posted_at: [nil, '']) }
  scope :order_by_seq, -> { order(:sequence) }
end
