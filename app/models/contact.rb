class Contact < ActiveRecord::Base
  attr_accessible :name, :phone, :email, :address1, :address2, :city, :state, :zip,
  :gender, :age_range, :home_owner, :maritial_status, :house_cost, :living_duration

  before_create :split_address2

  def split_address2
    if self.address2
      self.city, self.state, self.zip = self.address2.split(' ')
    end
  end


end
