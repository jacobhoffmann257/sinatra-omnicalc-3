require "sinatra"
require "sinatra/reloader"
require "http"
get("/") do
  "
  <h1>Welcome to your Sinatra App!</h1>
  <p>Define some routes in app.rb</p>
  "
end
get("/umbrella") do
erb(:umbrella_form)
end
post("/proccess_umbrella") do
  #this code wont work was sumurized
#@user_location = params.fetch("user_loc")
#gmaps_url = ""
#@raw_response = HTTP.get(gmaps_url).to_s
#@parsed_response = JSON.parse(@raw_response)
#loc_hash = @parsed_response.dig("results",0,"geometry","location")
#@lat = loc_hash.fetch("lat")
#@long = loc_hash.fetch("long")
erb(:umbrella_results)

end
