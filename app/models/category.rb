class Category < ApplicationRecord
    belongs_to :shop
    has_many :item_groups
end
