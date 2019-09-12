class Request < ApplicationRecord
    belongs_to :shop
    validates :title, presence: true, length: { in: 2..12 }
    validates :message, presence: true, length: { in: 2..70 }
    default_scope -> { order("id DESC") }
end
