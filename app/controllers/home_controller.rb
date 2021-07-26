class HomeController < ApplicationController
  API_TOKEN = "YOUR_API_TOKEN"

  def index
    require "net/http"

    @city = params[:city]

    if @city
      @url = "https://api.openweathermap.org/data/2.5/weather"
      @params = { :q => @city, :units => "metric", :appid => API_TOKEN }

      @uri = URI(@url)
      @uri.query = URI.encode_www_form(@params)

      @response = Net::HTTP.get_response(@uri)
      @body = @response.body if @response.is_a?(Net::HTTPSuccess)

      @data = JSON.parse(@body)

      @temp = @data["main"]
      @weather = @data["weather"][0]
    else
      @error = "no city added as a query param"

      puts @error
    end
  end
end
