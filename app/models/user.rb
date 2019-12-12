class User < ApplicationRecord
  has_many :orders
  has_many :line_items, through: :orders
  has_one :address
  validates :name, presence: true, uniqueness: true
  has_secure_password
  validates :email, uniqueness: true, format: {with: EMAIL_VALIDATOR, message: 'not valid' }

  after_create :send_welcome_mail
  after_destroy :ensure_an_admin_remains
  before_destroy :ensure_admins_cannot_be_deleted
  before_update :ensure_admins_cannot_be_updated

  class Error < StandardError
  end

  private
    def send_welcome_mail
      OrderMailer.welcome(self)
    end

    def ensure_admins_cannot_be_updated
      if email == 'admin@depot.com'
        errors.add(message: "Can't update an admin")
        throw :abort
      end
    end

    def ensure_admins_cannot_be_deleted
      if email == 'admin@depot.com'
        errors.add(message: "Can't delete an admin")
        throw :abort
      end
    end

    def ensure_an_admin_remains
      if User.count.zero?
        raise Error.new "Can't delete last user"
      end
    end
end
