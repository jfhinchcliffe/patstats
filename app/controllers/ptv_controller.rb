class PtvController < ApplicationController
  def bus
    api = set_api
    return_rt = api.broad_next_departures(1, 2097)
    
    @getting_real_time = return_rt
    @another = get_mode_and_route_information(return_rt)
    
  end

  def tram
  end

  def train
  end
  
  def set_api
    PtvTimetable::API.new(ENV['PTV_DEV_ID'], ENV['PTV_SECRET_KEY'])
  end
  
  def get_mode_and_route_information(api_info)
    all_route_info_array = []
    api_info["values"].each do |k|
      route_array = []
      k["platform"].each do |p|
        if p[0] == "stop"
          route_array << p[1].dig("location_name")
          route_array << p[1].dig("transport_type")
        end
        if p[0] == "direction"
          p[1].each do |pr|
            if pr[0] == "line"
              route_array << pr[1].dig("line_name")
            end
          end 
        end 
      end
      k.each do |j|
        if j[0]== "time_realtime_utc"
          if j[1] == nil
            route_array << "No Realtime"
          else
            route_array << j[1]
          end  
        end
      end
      all_route_info_array << route_array
    end
    return all_route_info_array
    
  end
  
  
end
