class PtvController < ApplicationController
  def bus
    api = set_api
    return_rt = api.broad_next_departures(2, 22936)
    
    @bus_set = get_mode_and_route_information(return_rt)
    
  end

  def tram
    api = set_api
    return_rt = api.broad_next_departures(1, 2097)
    
    @tram_set = get_mode_and_route_information(return_rt)
  end

  def train
  end
  
  def set_api
    PtvTimetable::API.new(ENV['PTV_DEV_ID'], ENV['PTV_SECRET_KEY'])
  end
  
  def get_mode_and_route_information(api_info)
    all_route_info_array = []
    api_info["values"].each do |values_level|
      route_hash = Hash.new
      route_hash[:run_id] = values_level.dig("run", "run_id")
      route_hash[:direction] = values_level.dig("platform", "direction", "direction_name")
      values_level["platform"].each do |platform_level|
        if platform_level[0] == "stop"
          route_hash[:location_name] = platform_level[1].dig("location_name")
          route_hash[:transport_type] = platform_level[1].dig("transport_type")
        end
        if platform_level[0] == "direction"
          platform_level[1].each do |direction_level|
            if direction_level[0] == "line"
              route_hash[:line_number] = direction_level[1].dig("line_number")
              route_hash[:line_name] = direction_level[1].dig("line_name")
            end
          end 
        end 
      end
      values_level.each do |time_level|
        if time_level[0]== "time_realtime_utc"
          if time_level[1] == nil
            route_hash[:real_time_value] = "No Realtime"
            route_hash[:real_time_present] = false
          else
            route_hash[:real_time_value] = time_level[1]
            route_hash[:real_time_present] = true
          end  
        end
      end
      all_route_info_array << route_hash
    end
    return all_route_info_array
    
  end
  
  
end
