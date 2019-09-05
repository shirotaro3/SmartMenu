class ItemGroup < ApplicationRecord
    belongs_to :category
    has_many :menu_items
end
