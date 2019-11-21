class OrderMailer < ApplicationMailer
  default from: 'abhishek <abhishek.rawat@vinsol.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.received.subject
  #
  def received(order)
    @order = order
    # @greeting = "Hi"

    mail to: order.email, subject: 'Pragmatic Store Order Confirmation'
  end


#to be completed
  def welcome(recipient, recipient_mail)
    @name = recipient
    mail to: recipient_mail, subject: 'Welcome'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.shipped.subject
  #
  def shipped(order)
    @order = order

    mail to: order.email, subject: 'Pragmatic Store Order Shipped'
  end
end
