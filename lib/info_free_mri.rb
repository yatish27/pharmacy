require 'headless'
require 'watir-webdriver'
require "watir-webdriver/wait"
class InfoFreeMri

  attr_accessor :browser

  USERNAME = 'vincentchhabra@gmail.com'
  PASSWORD = 'Giovanni99'

  def initialize(zip_codes)
    @zip_codes = zip_codes
  end

  def login
    @browser = Watir::Browser.new :firefox
    @browser.goto('https://new.infofree.com/login')
    @browser.text_field(:name,'username').value = USERNAME
    @browser.text_field(:name,'password').value = PASSWORD
    @browser.button(:id,'login_submit').click
    puts "Successfully Login"
  end

  def goto_consumers_page
    @browser.div(:id,'200MillionConsumers').link(:text,'Start').click
    puts "Consumer page selected"
  end

  def add_zipcodes(zip)
    sleep(10)
    @browser.text_field(:name,'search-alias-5932').when_present.value = zip
    sleep(1)
    @browser.text_field(:name,'search-alias-5932').fire_event('onkeyup')
    sleep(1)
    @browser.li(:id, 'search-alias-5932-selector-0').click
    puts "#{zip} added"
  end
  def add_phone_options
    @browser.link(:id,'ui-id-4').click
    sleep(1)
    @browser.checkbox(:name,'checkbox6217').click
    @browser.checkbox(:name,'checkbox6217').fire_event('onclick')
    sleep(1)
    @browser.checkbox(:name,'checkbox6269').click
    @browser.checkbox(:name,'checkbox6269').fire_event('onclick')
    sleep(1)
    puts "phone number options selected"
  end

  def get_base_count
    @browser.span(:class,'baseCount').text
  end
  def click_final_selection
    @browser.button(:text,"I'm Done, View Sales Leads").click
    puts "Final Lead Page"
  end


  def get_table_page_data
    page_trs = @browser.table(:class,'display_leads dataTable').rows
    #file_array = []
    (0..24).each do |i|
      begin
        file_row = []
        page_trs[i].click
        sleep(1)
        @browser.table(:id,'contactTable').rows.each do |row|
          file_row << row.text
        end
        if @browser.tables[7]
          @browser.tables[7].rows.each do |row|
            file_row << row.text
          end
        end
        # file_array << file_row
        puts file_row[0]
        final_row = clean_row(file_row)
        if final_row
          #c = Contact.create(final_row)
          #puts "contact saved!!!"
        end
      rescue=>e
        p e
      end
    end

  end

  def iterate_pages
    get_table_page_data
    puts "Total Count of records #{total_count}"
    (total_count/25.0).floor.times do |i|
      begin
        @browser.span(:text,"Next").click
        sleep(1.5)
        puts "====================================#Crawling Page#{i}"
        get_table_page_data
      rescue=>e
        p e
      end
    end
  end


  def total_count
    @total_count ||= @browser.p(:id,'totalSearchCountSpan').text.strip.gsub(',','').to_i
  end

  def run
    headless = Headless.new
    headless.start
    login
    goto_consumers_page
    sleep(4)
    @zip_codes.each do |zip|
      add_zipcodes(zip)
      sleep(1)
    end
    add_phone_options
    click_final_selection
    iterate_pages
    headless.destroy
  end

  def clean_row(row)
    #CSV.foreach(path) do |row|
    begin
      output_row = Hash.new
      output_row[:name] = row[0]
      arr = row[1].split(' ')
      if arr.count == 3
        output_row[:email] = arr[0]
        output_row[:phone] = (arr[1] + " " + arr[2])
      else
        output_row[:email] = ""
        output_row[:phone] = arr[0]+ " " +arr[1]
      end
      output_row[:address1] = row[2] unless row[2].blank?
      output_row[:address2] = row[3] unless row[3].blank?
      (2..9).each do |i|
        if row[i]

          case
          when row[i].match(/^Gender/)
            output_row[:gender] = row[i].gsub(/Gender/,"").strip
          when row[i].match(/^Age/)
            output_row[:age_range] = row[i].gsub(/Age/,"").strip
          when row[i].match(/^Home Ownership/)
            output_row[:home_owner] = row[i].gsub(/Home Ownership/,"").strip
          when row[i].match(/^Marital Status/)
            output_row[:maritial_status] = row[i].gsub(/Marital Status/,"").strip
          when row[i].match(/^home value/)
            output_row[:house_cost] = row[i].gsub(/home value/,"").strip
          when row[i].match(/^Length Of Residence/)
            output_row[:living_duration] = row[i].gsub(/Length Of Residence/,"").strip
          end
        end
      end
      return output_row
    rescue=>e
      puts e
    end

  end
end
