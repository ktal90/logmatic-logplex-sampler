require 'sinatra'
require 'net/http'
require 'uri'
require 'json'


socket = TCPSocket.new 'api.logmatic.io', 10514

post '/sampler/:rate/:token' do

  # config
  uri = URI.parse("https://api.logmatic.io/v1/input")

  # Create the HTTP objects
  proxy_http = Net::HTTP.new(uri.host, uri.port)
  proxy_http.use_ssl = true
  proxy_request = Net::HTTP::Post.new("#{uri.path}/#{params['token']}?#{request.query_string}", {'Content-Type' => 'application/json'})

  lines = []
  request.body.each do |line|
    lines.push(line)
  end

  # Do the sampling
  nb_samples = [(lines.length * params["rate"].to_i / 100).to_i, 1].max
  sampled = lines.sample(nb_samples)
  proxy_request.body = sampled.to_json

  # Send the request to Logmatic.io
  proxy_http.request(proxy_request)

  "#{nb_samples}:  #{sampled.to_json} " #"// #{proxy_response}"
end
