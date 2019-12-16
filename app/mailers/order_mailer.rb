class OrderMailer < ApplicationMailer
  default from: 'abhishek <abhishek.rawat@vinsol.com>'
  around_action :switch_locale

  def received(order)
    @order = order
    headers['X-SYSTEM-PROCESS-ID'] = Process.pid

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

  def switch_locale(&action)
    locale = I18n.locale || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
