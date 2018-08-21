class Admin::OrderMailer < ApplicationMailer
  def notice_request order
    @order = order
    mail to: order.user.email, subject: t(".subject")
  end
end
