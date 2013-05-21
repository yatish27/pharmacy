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

  filter :age_range, :as => :select, :collection => Contact.select("DISTINCT age_range").collect {|o| [o.age_range, o.age_range]}
  filter :zip, :as => :select, :collection => Contact.select("DISTINCT zip").collect {|o| [o.zip, o.zip]}
  filter :home_owner, :as => :select, :collection => Contact.select("DISTINCT home_owner").collect {|o| [o.home_owner, o.home_owner]}
end
