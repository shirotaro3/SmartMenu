class Menu < ApplicationRecord
    belongs_to :shop
    has_many :item_groups, dependent: :destroy
    validates :color, presence: true
    validates :menu_name, presence: true, length: { in: 2..10 }

end