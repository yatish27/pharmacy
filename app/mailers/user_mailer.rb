class UserMailer < ActionMailer::Base
  default from: 'notifications@prgi.com'
  DEFAULT_RECEIPTS = %w(yatishmehta27@gmail.com)

  def report_email(report={})
    @report = report
    mail(to: DEFAULT_RECEIPTS,
         subject: "Scraping Report:#{Time.now.strftime("%I:%M %p %b %d")}")
  end
end
