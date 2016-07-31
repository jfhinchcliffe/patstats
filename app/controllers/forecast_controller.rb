class ForecastController < ApplicationController
  def weather_check
    @weather_api_call = ForecastIO.forecast(-37.820197, 144.949633, params: { units: 'si' })
    @weather = {'item' => [{'text' => weather_html(@weather_api_call)}]}
    render json: @weather
  end
  
  def index
    @weather_api_call = ForecastIO.forecast(-37.820197, 144.949633, params: { units: 'si' })
    @weather = {'item' => [{'text' => weather_html(@weather_api_call)}]}
  end
  
  def weather_html(weather_api_call)
    temp = weather_api_call.currently.temperature
    summary = weather_api_call.currently.summary
    "<div class='main-stat t-size-x72' align='center'>#{temp.floor}°</div> <div class='t-size-x20' align='center'>#{summary}</div>"
  end

end