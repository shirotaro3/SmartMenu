class Tax < ApplicationRecord
    
    validates :rate, :numericality => { :greater_than => 1.0,:less_than=> 10.0 }
    def calc(price)
        (BigDecimal(price.to_s) * BigDecimal(self.rate.to_s)).to_f.floor.to_s
    end
end
