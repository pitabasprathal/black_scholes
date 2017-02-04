class MarketValuesController < ApplicationController
  before_action :set_market_value, only: [:show, :edit, :update, :destroy]


  def calculator
    @market_value = MarketValue.new
  end

  def result
    @market_value = MarketValue.new(market_value_params)
    if @market_value.valid?
      @status = true
      @result = BlackScholeEquation::Calculator.new(@market_value)
      @time , @put ,@call = @result.time_graph
    else
      @status = false
    end
  end

  # GET /market_values
  # GET /market_values.json
  def index
    @market_values = MarketValue.all.where(:user_id=>current_user.id).paginate(:page => params[:page], :per_page => 7)
    @market_value = MarketValue.new
  end

  # GET /market_values/1
  # GET /market_values/1.json
  def show
    @result = BlackScholeEquation::Calculator.new(@market_value)
  end

  # GET /market_values/new
  def new
    @market_value = MarketValue.new
  end

  # GET /market_values/1/edit
  def edit
  end

  # POST /market_values
  # POST /market_values.json
  def create
    @market_value = MarketValue.new(market_value_params)
    if @market_value.save
      @market_value = MarketValue.new
      @market_values = MarketValue.all.where(:user_id=>current_user.id).paginate(:page => params[:page], :per_page => 7)
      @status = true
    else
      @status = false
    end
  end

  # PATCH/PUT /market_values/1
  # PATCH/PUT /market_values/1.json
  def update
    if @market_value.update(market_value_params)
      @market_value = MarketValue.new
      @market_values = MarketValue.all.where(:user_id=>current_user.id).paginate(:page => params[:page], :per_page => 7)
      @status = true
    else
      @status = false
    end
  end

  # DELETE /market_values/1
  # DELETE /market_values/1.json
  def destroy
    @market_value.destroy
    @market_value = MarketValue.new
    @market_values = MarketValue.all.where(:user_id=>current_user.id).paginate(:page => params[:page], :per_page => 7)
    @status = true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_market_value
      @market_value = MarketValue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def market_value_params
      params.require(:market_value).permit(:stock_price, :volatility, :interest_rate, :maturity_time, :strike_price, :direction_id,:user_id)
    end
end
