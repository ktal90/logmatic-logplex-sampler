require 'sinatra'
require 'thread'

call_number = 0
scale_factor = 1000

get "/loaderio-61161d1f086423cc02a6cbb28bd9a2e5" do
  File.read('loaderio-61161d1f086423cc02a6cbb28bd9a2e5.txt')
endget "/loaderio-61161d1f086423cc02a6cbb28bd9a2e5/" do
  File.read('loaderio-61161d1f086423cc02a6cbb28bd9a2e5.txt')
end


post '/sampler/:rate/:token' do

  time = Time.now.getutc
  puts time.to_s + " received call"

  sample_rate = 100 / params["rate"].to_i
  sample_rate = 1 if sample_rate < 0 || sample_rate > 100

  # to be more precise scale the rate
  sample_rate = (sample_rate * scale_factor).to_i

  call_number += 1
  call_number = 0 if call_number == scale_factor
  if (scale_factor * call_number % sample_rate == 0)

    # config
    endpoint = "https://api.logmatic.io/v1/input/#{params['token']}/?#{request.query_string}"
    uri = URI.parse(endpoint)

    # Create the HTTP objects
    proxy_http = Net::HTTP.new(uri.host, uri.port)
    proxy_http.use_ssl = true
    proxy_request = Net::HTTP::Post.new(endpoint, {"Content-Type" => "application/logplex-1"})


    proxy_request.body = request.body.read
    proxy_http.request proxy_request
    puts time.to_s + " pushed"
  else
    puts time.to_s + " dropped"
  end
end
