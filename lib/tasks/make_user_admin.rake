namespace :make_user_admin do
  desc "this sets user's role to admin by checking mail"
  task :set_user_to_admin, [:email] => :environment do |t, args|
    User.where(email: args[:email]).update(role: 'admin')
  end
end
