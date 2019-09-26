class InquiryMailer < ApplicationMailer
    def send_mail(inquiry)
        @inquiry = inquiry
        mail(
            from: 'system@smartmenu.com',
            to:  'winterleaves2219.443@gmail.com',
            subject: '問い合わせがありました'
        )
    end
end
