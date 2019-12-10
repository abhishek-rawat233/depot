class OrderMailer < ApplicationMailer
  default from: 'abhishek <abhishek.rawat@vinsol.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.received.subject
  #
  def received(order)
    @order = order
    # attachements.inline[] = File.read(@order.image_url)
    # @greeting = "Hi"
    headers["X-SYSTEM-PROCESS-ID"] = Process.pid

    mail to: order.email, subject: 'Pragmatic Store Order Confirmation'
  end


#to be completed
  def welcome(recipient, recipient_mail)
    @name = recipient
    mail to: recipient_mail, subject: 'Welcome'
  end

  def send_user_history(user)
    @user = user
    @orders = @user.orders
    mail to: @user.email, subject: 'History'
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
