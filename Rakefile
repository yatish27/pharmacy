#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Pharmacy::Application.load_tasks


task :upload_zipcodes => :environment do
  CSV.foreach("#{Rails.root}/infofree_zip_codes_to_scrape.csv") do |row|
    begin
      code = row[0]
      z = Zipcode.find_by_code(code)
    rescue=>e
      z = Zipcode.create(:code => code)
      InfoFreeWorker.perform_async(z.id)
    end
  end
end
