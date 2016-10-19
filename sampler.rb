require 'sinatra'
require 'net/http'
require 'uri'

require 'logger'
require 'json'


enable :logging, :dump_errors, :raise_errors


=begin
  t = %w[text/css text/html application/javascript]
  request.accept              # ['text/html', '*/*']
  request.accept? 'text/xml'  # true
  request.preferred_type(t)   # 'text/html'
  request.body                # request body sent by the client (see below)
  request.scheme              # "http"
  request.script_name         # "/example"
  request.path_info           # "/foo"
  request.port                # 80
  request.request_method      # "GET"
  request.query_string        # ""
  request.content_length      # length of request.body
  request.media_type          # media type of request.body
  request.host                # "example.com"
  request.get?                # true (similar methods for other verbs)
  request.form_data?          # false
  request["some_param"]       # value of some_param parameter. [] is a shortcut to the params hash.
  request.referrer            # the referrer of the client or '/'
  request.user_agent          # user agent (used by :agent condition)
  request.cookies             # hash of browser cookies
  request.xhr?                # is this an ajax request?
  request.url                 # "http://example.com/example/foo"
  request.path                # "/example/foo"
  request.ip                  # client IP address
  request.secure?             # false (would be true over ssl)
  request.forwarded?          # true (if running behind a reverse proxy)
  request.env                 # raw env hash handed in by Rack
=end

post '/' do

  log = Logger.new(STDOUT)
  log.info "here"
  uri = URI.parse("https://api.logmatic.io/v1/input/zYZIRBwJTZWGKlLwdpj3fQ?&appname=sense360")


  # Create the HTTP objects
  proxy_http = Net::HTTP.new(uri.host, uri.port)
  proxy_http.use_ssl = true


  proxy_request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type': 'text/plain'})

  #proxy_request.body = ",lknkkn" #request.body

  # Send the request
  proxy_response = proxy_http.request(proxy_request)

  "ended #{uri.request_uri} // #{proxy_response}"
end
