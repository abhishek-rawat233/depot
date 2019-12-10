class User < ApplicationRecord
  has_many :orders
  has_many :line_items, through: :orders
  validates :name, presence: true, uniqueness: true
  has_secure_password
  # Create a constant file in initializers and separate all constants in that file.
  validates :email, uniqueness: true, format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: 'not valid' }

  after_create_commit :send_welcome_mail
  after_destroy :ensure_an_admin_remains
  before_destroy :ensure_admins_cannot_be_deleted
  before_update :ensure_admins_cannot_be_updated

  class Error < StandardError
  end

  private
    def send_welcome_mail
      # This is not working. We will check this once mailer is setup
      # Use letter-opener gem for development environment.
      OrderMailer.welcome(:name, :email)
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
