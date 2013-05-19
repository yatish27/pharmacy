class CreateContacts < ActiveRecord::Migration
  def up
    create_table :contacts do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :gender
      t.string :age_range
      t.string :home_owner
      t.string :maritial_status
      t.string :house_cost
      t.string :living_duration
      t.timestamps
    end
  end

  def down
  end
end
