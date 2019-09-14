module ApplicationHelper
    require 'chunky_png'

    # QRコード表示
    def qrcode(text, options = {})
        qr = ::RQRCode::QRCode.new(text)
     return ChunkyPNG::Image.from_datastream(qr.as_png.resize(500,500).to_datastream).to_data_url
    end
    
    # 郵便番号表示
    def postal_code(postal_code)
        if postal_code.length == 7
            postal_code = postal_code.split("").insert(3, '-').join
        else
            postal_code
        end
    end

    # datetimeを見やすく
    def simple_date(datetime)
        datetime.strftime("%Y年%m月%d日%H:%M")
    end

    # 税率計算
    def tax_calc(item_price)
        (BigDecimal(item_price.to_s) * BigDecimal(current_tax.rate.to_s)).to_f.floor.to_s
    end
        
    ## 以下コントローラーに記述
    # def current_tax
    #     @tax = Tax.first
    # end
end
