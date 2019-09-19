class Category < ApplicationRecord
    belongs_to :shop
    has_many :item_groups

    validates :name, presence: true, length: { maximum: 10 }

    before_destroy :must_not_destroy
    def must_not_destroy
        throw(:abort) if self.item_groups.any?
    end
end
