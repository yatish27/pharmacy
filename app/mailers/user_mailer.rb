class UserMailer < ActionMailer::Base
  default from: 'notifications@prgi.com'
  DEFAULT_RECEIPTS = %w(yatishmehta27@gmail.com gcjain@gmail.com)

  def report_email(report,total)
    @report = report
    @total = total
    time = Time.now
    subject = time.strftime("#{time.day.ordinalize} %b")
    mail(to: DEFAULT_RECEIPTS,
         subject: "InfoFree Report:#{subject}")
  end
end
