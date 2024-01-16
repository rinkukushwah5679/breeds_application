class HomeController < ApplicationController
  require "uri"
  require "net/http"
  def index
    # url = URI("https://dog.ceo/api/breeds/list/all")
    # https = Net::HTTP.new(url.host, url.port)
    # https.use_ssl = true

    # request = Net::HTTP::Get.new(url)

    # response = https.request(request)
    # json = JSON.parse(response.body)
    # @breeds = {}
    # data = json['message']
    # data.each do |key, value|
    #   if value == []
    #     @breeds[key] = key.capitalize
    #   else
    #     value.each do |breed|
    #       @breeds["#{key}/#{breed}"] = "#{breed.capitalize} #{key.capitalize}"
    #     end
    #   end
    # end
  end
  def fetch_breed
    begin
      url = URI("https://dog.ceo/api/breed/#{params[:breed]&.downcase.to_s}/images/random")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)

      response = https.request(request)
      if response.code == "200" || response.code == "404"
        @breed_data = JSON.parse(response.body)
      else
        @breed_data = ""
      end
    rescue StandardError => e
      @breed_data = {"errors" => e.message, "code" => 503}
    end
  end
end
