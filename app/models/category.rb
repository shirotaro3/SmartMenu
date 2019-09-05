class Category < ApplicationRecord
    belongs_to :shop
    has_many :menu_items
end
