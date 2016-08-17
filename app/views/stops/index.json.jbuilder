json.array!(@stops) do |stop|
  json.extract! stop, :id, :routes_serviced, :stop_name, :operator, :diva_id, :mode, :currently_checked
  json.url stop_url(stop, format: :json)
end
