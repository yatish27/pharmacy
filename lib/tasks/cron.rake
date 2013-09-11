namespace :cron do
  desc "Calculates the count and send a mail"
  task :generate_report => :environment do
    report = Contact.group(:zip).order('1 DESC').count
    total = Contact.count
    UserMailer.report_email(report,total).deliver
  end
end