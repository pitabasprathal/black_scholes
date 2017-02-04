module BlackScholeEquation
  class Calculator
    A1, A2, A3,A4,A5 = 0.31938153, -0.356563782, 1.781477937, -1.821255978, 1.330274429

    include Math
    def initialize(market_value)
      @market_data = market_value
      @stock = market_value.stock_price
      @strike = market_value.strike_price
      @time = market_value.maturity_time
      @interest = market_value.interest_rate
      @volatility = market_value.volatility
    end
	  public
      
    def delta_call
      norm_sdist( d_one )
    end

    def delta_put
      delta_call - 1
    end

    def gamma
      phi( d_one ) / ( @stock * @volatility * sqrt(@time) )
    end

    def theta_call
      term1 = @stock * phi( d_one ) * @volatility / ( 2 * sqrt(@time) )
      term2 = @interest * @strike * exp(-1.0 * @interest * @time) * norm_sdist( d_two )
      ( - term1 - term2 ) / 365.0
    end

    def theta_put
      term1 = @stock * phi( d_one ) * @volatility / ( 2 * sqrt(@time) )
      term2 = @interest * @strike * exp(-1.0 * @interest * @time) * norm_sdist( - d_two )
      ( - term1 + term2 ) / 365.0
    end

    def vega
      @stock * sqrt(@time) * phi(d_one)
    end

    def option_call
      first_term = @stock * norm_sdist( d_one )
      second_term = norm_sdist( d_two ) * exp(-1.0 * @interest * @time) * @strike
	
      expected_value = first_term - second_term
      return expected_value
    end

    def option_put
      first_term = @strike * exp(-1.0 * @interest * @time) * norm_sdist( -1.0 * d_two ) 
      second_term = @stock * norm_sdist( -1.0 * d_one )
      expected_value = first_term - second_term
    end

    def rho_call
      @interest * @time * exp(-1.0 * @interest * @time) * norm_sdist( d_two )
    end

    def rho_put
      - @interest * @time * exp(-1.0 * @interest * @time) * phi(- d_two )
    end

    def d_one
      numerator = ( log(@stock / @strike) + (@interest + 0.5 * @volatility ** 2.0 ) * @time)
      denominator = ( @volatility * sqrt(@time) )
      numerator / denominator
    end

    def d_two 
      d_one - ( @volatility * sqrt(@time) )
    end

    def norm_sdist( z )
      a1, a2, a3, a4, a5 = 0.31938153, -0.356563782, 1.781477937, -1.821255978, 1.330274429
      l = z.abs
      k = 1.0 / (1.0 + 0.2316419 * l)
      w = 1.0 - 1.0 / sqrt(2*PI)* exp(-l*l/2.0) * (A1*k + A2*k*k + A3*(k**3) + A4*(k**4) + A5*(k**5))
      w = 1.0 - w if z < 0
      return w
    end

    def phi(x)
      numerator = exp(-1.0 * x*x / 2.0)
      denominator = sqrt(2.0 * PI)
      numerator / denominator
    end	

    def time_graph
      put_value = Array.new
      call_value = Array.new
      time = Array.new(10) { rand(1...1000) }
      time << @time
      time.sort!.each do |time|
        @time = time
        put_value << option_put
        call_value << option_call
      end
      @time = @market_data.maturity_time
      return time , put_value , call_value
    end

    def stock_graph
      put_value = Array.new
      call_value = Array.new
      stock = Array.new(10) { rand(1...1000) }
      stock << @stock
      stock.sort!.each do |stock|
        @stock = stock
         put_value << option_put
         call_value << option_call
      end
      @stock = @market_data.stock_price
    end

    def volatility_graph
      put_value = Array.new
      call_value = Array.new
      volatility = Array.new(10) { rand(1...100) }
      volatility << @volatility
      volatility.sort!.each do |volatility|
        @volatility = volatility
         put_value << option_put
         call_value << option_call
      end
      @volatility = @market_data.volatility
    end 

    def strike_graph
      put_value = Array.new
      call_value = Array.new
      strike = Array.new(10) { rand(1...1000) }
      strike << @strike
      strike.sort.each do |strike|
        @strike = strike
         put_value << option_put
         call_value << option_call
      end
      @strike = @market_data.strike_price
    end

    def interest_graph
      put_value = Array.new
      call_value = Array.new
      interest = Array.new(10) { rand(1...100) }
      interest << @interest
      interest.sort.each do |interest|
        @interest = interest
         put_value << option_put
         call_value << option_call
      end
      @interest = @market_data.interest_rate
    end 		  
  end
end