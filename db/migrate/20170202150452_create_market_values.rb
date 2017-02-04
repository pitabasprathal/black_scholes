class CreateMarketValues < ActiveRecord::Migration[5.0]
  def change
    create_table :market_values do |t|
      t.float :stock_price
      t.float :volatility
      t.float :interest_rate
      t.float :maturity_time
      t.float :strike_price
      t.references :direction, foreign_key: true

      t.timestamps
    end
  end
end
