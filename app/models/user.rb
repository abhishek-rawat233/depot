class User < ApplicationRecord
  #6
  has_many :orders
  has_many :line_items, through: :orders
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
      # OrderMailer.welcome(:name, :email)
    end

    # Update method name. Here we are only allowing this for special email not emails.
    # Extract `special email` in constants.
    # You need to stop the deletion, instead of raising an exception.
    # Study how to rollback in callbacks.
    def ensure_admins_cannot_be_updated
      raise Error.new "Can't update an admin" if email == 'admin@depot.com'
    end

    # Update method name. Here we are only allowing this for special email not emails.
    # Extract `special email` in constants.
    # You need to stop the deletion, instead of raising an exception.
    # Study how to rollback in callbacks.
    def ensure_admins_cannot_be_deleted
      raise Error.new "Can't delete an admin" if email == 'admin@depot.com'
    end

    def ensure_an_admin_remains
      if User.count.zero?
        raise Error.new "Can't delete last user"
      end
    end
end
