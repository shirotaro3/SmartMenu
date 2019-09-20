class Request < ApplicationRecord
    belongs_to :shop
    validates :title, presence: true, length: { maximum: 12 }
    validates :message, presence: true, length: { maximum: 200 }
    default_scope -> { order("id DESC") }
end
