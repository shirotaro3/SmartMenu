class Menu < ApplicationRecord
    belongs_to :shop
    has_many :menu_items
    has_many :special_features

    accepts_nested_attributes_for :menu_items, allow_destroy: true, reject_if: :all_blank
end