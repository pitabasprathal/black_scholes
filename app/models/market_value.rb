class MarketValue < ApplicationRecord
  belongs_to :direction
  belongs_to :user
  validates :stock_price, presence: true,  :numericality => {:greater_than =>0}
  validates :strike_price, presence: true,  :numericality => {:greater_than =>0}
  validates :volatility, presence: true,  :numericality => {:greater_than =>0,:less_than=>100}
  validates :interest_rate, presence: true,  :numericality => {:greater_than =>0,:less_than=>100}
  validates :maturity_time, presence: true,  :numericality => {:greater_than =>0}
end
