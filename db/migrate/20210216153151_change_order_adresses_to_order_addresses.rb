class ChangeOrderAdressesToOrderAddresses < ActiveRecord::Migration[6.0]
  def change
    rename_table :order_adresses, :order_addresses
  end
end
