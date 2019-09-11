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
            return postal_code
        else
            return postal_code
        end
    end

    # datetimeを見やすく
    def simple_date(datetime)
        datetime.strftime("%Y年%m月%d日%H:%M")
    end
end
