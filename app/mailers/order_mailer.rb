class OrderMailer < ApplicationMailer
  default from: 'abhishek <abhishek.rawat@vinsol.com>'

  def received(order)
    @order = order

    mail to: order.email, subject: 'Pragmatic Store Order Confirmation'
  end


  def welcome(user)
    @name = user.name
    mail to: user.email, subject: 'Welcome'
  end

  def shipped(order)
    @order = order

    mail to: order.email, subject: 'Pragmatic Store Order Shipped'
  end
end
