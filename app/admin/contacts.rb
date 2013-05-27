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
    column :age_range
    column :maritial_status
    column :home_owner
    column :house_cost
    column :living_duration
  end

  filter :age_range, :as => :select, :collection => Contact.select("DISTINCT age_range").map(&:age_range).compact.collect {|o| [o.age_range, o.age_range]}
  filter :zip, :as => :select, :collection => Contact.select("DISTINCT zip").map(&:zip).compact.collect {|o| [o.zip, o.zip]}
  filter :home_owner, :as => :select, :collection => Contact.select("DISTINCT home_owner").map(&:home_owner).compact.collect {|o| [o.home_owner, o.home_owner]}
end
