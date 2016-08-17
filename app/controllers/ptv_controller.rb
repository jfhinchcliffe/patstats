class PtvController < ApplicationController
  
  def test_stop_finding
    @stop_info = []
    @stop_info = Stop.where("currently_checked = ?", true)
    real_time_present = []
    api = set_api
    @stop_info.each do |si|
      mode = si.mode
      stop_id = si.diva_id
      real_time_present << get_mode_and_route_information(api.broad_next_departures(mode, stop_id))
    end
    @real_time_status_of_services = []
    real_time_present.each do |rtp|
      @real_time_status_of_services << get_realtime_percentage(rtp)
    end
    overall_percentage = 0
    @real_time_status_of_services.each do |rtsos|
      overall_percentage += rtsos
    end
    overall_percentage = overall_percentage / @real_time_status_of_services.length
    @val = real_time_up_or_down(overall_percentage, "Bus")
    render json: @val
  end
  
  def bus
    api = set_api
    return_rt = api.broad_next_departures(2, 22936)
    @all_stop_services = get_mode_and_route_information(return_rt)
    @realtime_percentage = get_realtime_percentage(@all_stop_services)
  end
  
  def tram
    api = set_api
    return_rt = api.broad_next_departures(1, 2097)
    @all_stop_services = get_mode_and_route_information(return_rt)
    @realtime_percentage = get_realtime_percentage(@all_stop_services)
  end
  
  def train
  end
  
  def tram_check
    api = set_api
    return_rt = api.broad_next_departures(1, 2097)
    @all_stop_services = get_mode_and_route_information(return_rt)
    @realtime_percentage = get_realtime_percentage(@all_stop_services)
    @formatted = board_response_html(@realtime_percentage, "Tram")
    render json: @formatted
  end
  
  def bus_check
    api = set_api
    return_rt = api.broad_next_departures(2, 22936)
    @all_stop_services = get_mode_and_route_information(return_rt)
    @realtime_percentage = get_realtime_percentage(@all_stop_services)
    @formatted = board_response_html(@realtime_percentage, "Bus")
    render json: @formatted
  end
  
  private
  
    def set_api
      PtvTimetable::API.new(ENV['PTV_DEV_ID'], ENV['PTV_SECRET_KEY'])
    end
    
    def get_realtime_percentage(list_of_services)
      working_services = 0
      not_working_services = 0
      first_5_services = list_of_services.first(5)
      first_5_services.each do |service|
        if service[:real_time_present] == true
          working_services += 1
        elsif service[:real_time_present] == false
          not_working_services += 1
        end
      end
      return working_services * 20
    end
    
    def board_response_html(realtime_percentage, mode)
      sentiment_colour = ""
      if realtime_percentage <= 40
        sentiment_colour = 'negative'
      elsif realtime_percentage > 40 && realtime_percentage <= 70
        sentiment_colour = ''
      elsif realtime_percentage > 70
        sentiment_colour = 'positive'
      end
      {'item' => [{'text' => "<div class='main-stat t-size-x72 #{sentiment_colour}' align='center'>#{realtime_percentage}%</div> <div class='t-size-x20' align='center'>#{mode} RT response %</div>"}]}
    end
    
    def real_time_up_or_down(realtime_percentage, mode)
      sentiment_colour = ""
      status = ""
      if realtime_percentage <= 10
        sentiment_colour = 'negative'
        status = "Down"
      elsif realtime_percentage > 11 && realtime_percentage <= 30
        sentiment_colour = ''
        status = "Up"
      elsif realtime_percentage > 31
        sentiment_colour = 'positive'
        status = "Up"
      end
      {'item' => [{'text' => "<div class='main-stat t-size-x72 #{sentiment_colour}' align='center'>#{status}!</div> <div class='t-size-x20' align='center'>#{mode} RT status</div>"}]}
    end
    
    def get_mode_and_route_information(api_info)
      all_route_info_array = []
      api_info["values"].each do |values_level|
        route_hash = Hash.new
        route_hash[:run_id] = values_level.dig("run", "run_id")
        route_hash[:direction] = values_level.dig("platform", "direction", "direction_name")
        route_hash[:location_name] = values_level.dig("platform", "stop", "location_name")
        route_hash[:transport_type] = values_level.dig("platform", "stop", "transport_type")
        route_hash[:line_number] = values_level.dig("platform", "direction", "line", "line_number")
        route_hash[:line_name] = values_level.dig("platform", "direction", "line", "line_name")
        route_hash[:test] = values_level.dig("time", "time_realtime_utc")
        if values_level.dig("time_realtime_utc") == nil
          route_hash[:real_time_value] = "No Realtime"
          route_hash[:real_time_present] = false
          route_hash[:countdown_to_arrival] = 'No Countdown'
        else
          route_hash[:real_time_value] = Time.parse(values_level.dig("time_realtime_utc")).in_time_zone('Melbourne').strftime("%I:%M:%S %p")
          route_hash[:real_time_present] = true
          route_hash[:countdown_to_arrival] = ((Time.now - Time.parse(values_level.dig("time_realtime_utc"))) / 60).floor
        end
        
        all_route_info_array << route_hash
      end
      return all_route_info_array
    end
    
    def get_stop_information(location_info)
      all_stop_array = location_info[1]
  
      return all_stop_array
    end
  
end
