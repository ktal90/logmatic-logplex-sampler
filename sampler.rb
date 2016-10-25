require 'sinatra'
require 'thread'

# Global variables
call_number = 0
scale_factor = 1000

post '/sampler/:rate/:token' do

  # Sample rate (1 to 100)
  sample_rate = 100 / params["rate"].to_i
  sample_rate = 100 if sample_rate < 0 || sample_rate > 100

  # Need to scale to be more exact
  sample_rate = (sample_rate * scale_factor).to_i

  call_number += 1
  call_number = 0 if call_number == scale_factor
  # We use the modulo to do the sampling
  if (scale_factor * call_number % sample_rate == 0)

    # Logmatic.io's config
    endpoint = "https://api.logmatic.io/v1/input/#{params['token']}/?#{request.query_string}"
    uri = URI.parse(endpoint)

    # Create the HTTP objects
    proxy_http = Net::HTTP.new(uri.host, uri.port)
    proxy_http.use_ssl = true
    proxy_request = Net::HTTP::Post.new(endpoint, {"Content-Type" => "text/plain"})

    # Forward it to Logmatic.io
    r = proxy_request.body = request.body.read.strip
    puts "#{r.code}: #{r.message} (#{r.read_body})"
    puts "Send to Logmatic: #{proxy_request.body}"
  else
    puts "Dropped"
  end
end
