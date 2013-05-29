ActiveAdmin.register Contact do
  scope :all, :default => true

  index do
    selectable_column
    column "Name" do |contact|
      link_to contact.name, admin_contact_path(contact)
    end
    column :address1
    column :address2
    column :gender
    default_actions
  end

  csv do
    column :name
    column :email
    column :phone
    column :address1
    column :address2
    column :city
    column :state
    column :zip
    column :gender
    column :age_range
    column :maritial_status
    column :home_owner
    column :house_cost
    column :living_duration
  end

  filter :age_range, :as => :select, :collection => proc { Contact.select("DISTINCT age_range").map(&:age_range).compact.collect {|o| [o, o]}}
  filter :zip, :as => :select, :collection => proc{ Contact.select("DISTINCT zip").map(&:zip).compact.collect {|o| [o , o]}}
  filter :gender,:as => :select, :collection => Contact.select("DISTINCT gender").map(&:gender).compact.collect {|o| [o , o]}
  filter :created_at,:as => :date_range
end
