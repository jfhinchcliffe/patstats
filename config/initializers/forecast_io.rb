require 'forecast_io'  

#ForecastIO.configure do |config|    
#  config.api_key = Figaro.env.forecast_io_key  
#end

ForecastIO.configure do |config|    
  config.api_key = ENV['FORECAST_IO_KEY']
end