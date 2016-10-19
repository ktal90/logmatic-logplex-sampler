require 'sinatra'
require 'net/http'
require 'uri'
require 'json'

gl = 10

post '/sampler/:rate/:token' do

  # config
  uri = URI.parse("https://api.logmatic.io/v1/input")


  # Create the HTTP objects
  proxy_http = Net::HTTP.new(uri.host, uri.port)
  proxy_http.use_ssl = true
  proxy_request = Net::HTTP::Post.new("#{uri.path}/#{params['token']}?#{request.query_string}", {'Content-Type' => 'application/json'})
  # proxy_request.body = request.read_body

  lines = []
  gl = gl + 1
  request.body.each do |line|
    lines.push line
  end
  proxy_request.body = lines.to_json

  #proxy_request.body = ",lknkkn" #request.body

  # Send the request to Logmatic.io
  proxy_response = proxy_http.request(proxy_request)

  "#{gl}:  #{lines.to_json} // #{proxy_response}"
end
