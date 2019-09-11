class Menu < ApplicationRecord
    belongs_to :shop
    has_many :menu_items
    has_many :special_features
    has_many :item_groups
    validates :color, presence: true
    validates :menu_name, presence: true, length: { in: 2..10 }
end