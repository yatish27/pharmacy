class InfoFreeWorker
  include Sidekiq::Worker
  sidekiq_options queue: "infofree_contact", :backtrace => true

  def perform(zip)
    obj = InfoFree.new([zip.code])
    obj.run
    zip.status = true
    zip.save
  end
end
