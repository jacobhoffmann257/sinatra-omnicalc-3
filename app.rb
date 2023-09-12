require "sinatra"
require "sinatra/reloader"
require "http"
require "sinatra/cookies"

get("/") do
  cookies["color"] = "pink"
  "
  <h1>Welcome to your Sinatra App!</h1>
  <p>Define some routes in app.rb</p>
  "
end
get("/umbrella") do
erb(:umbrella_form)
end
post("/proccess_umbrella") do
gmaps_key = ENV.fetch("GMAPS_KEY")
@user_location = params.fetch("user_loc")
gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{@user_location}&key=#{gmaps_key}"
raw_response = HTTP.get(gmaps_url).to_s
parsed_response = JSON.parse(raw_response)
loc_hash = parsed_response.dig("results",0,"geometry","location")
lat = loc_hash.fetch("lat")
long = loc_hash.fetch("lng")
@long_string = lat.to_s
@lat_string = long.to_s
cookies["last_location"] = $user_location
cookies["last_lat"] = @lat_string
cookies["last_long"] = @long_string
#parsing pirate api
pirate_key = ENV.fetch("PIRATE_WEATHER_KEY")
pirate_url = "https://api.pirateweather.net/forecast/#{pirate_key}/#{long},#{lat}"
raw_pirate_data = HTTP.get(pirate_url)
parsed_pirate_data = JSON.parse(raw_pirate_data)
current_pirate = parsed_pirate_data.fetch("currently")
currently_temp = current_pirate.fetch("temperature")
@long_lat = "The Longitude and latitude is #{@long_string}, #{@lat_string}"
@temperature_string = "The Current tempature in #{@user_location} is #{currently_temp}"
hour_parse = parsed_pirate_data.fetch("hourly")
hour_data = hour_parse.fetch("data")
next_twelve = hour_data[1..12]
will_rain = 0
count = 0
next_twelve.each do |x|
  if(x.fetch("precipProbability")>=10)
    will_rain = will_rain + 1
  end
  
end
@answer = ""
if(will_rain >= 1)
  @answer = "You need an Umbrella"
  else
  @answer = "You don't need an Umbrella"
  end
erb(:umbrella_results)
end
post("/openai") do
end
post("/openai_record") do
end
