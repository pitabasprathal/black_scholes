class AddUserRefToMarketValue < ActiveRecord::Migration[5.0]
  def change
    add_reference :market_values, :user, foreign_key: true
  end
end
