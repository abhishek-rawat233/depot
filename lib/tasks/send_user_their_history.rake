namespace :send_user_their_history do
  desc "to user their order history"
  task :send_mail => :environment do
    User.all.each do |user|
      OrderMailer.send_user_history(user).deliver
    end
  end
end
