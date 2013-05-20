class InfoFreeWorker
  include Sidekiq::Worker
  sidekiq_options queue: "infofree_contact", :backtrace => true

  def perform(id)
    zip = Zipcode.find id
    obj = InfoFree.new([zip.code])
    obj.run
    zip.status = true
    zip.save
  end
end
