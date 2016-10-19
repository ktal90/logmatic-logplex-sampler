require 'sinatra'
require 'logger'
call_number = 0
scale_factor = 1000



configure do
  LOG = Logger.new(STDOUT)
  LOG.level = Logger.const_get ENV['LOG_LEVEL'] || 'DEBUG'

  LOG.info 'I am logging something.'
end

post '/sampler/:rate/:token' do



  redirect "http://requestb.in/14pfqnj1?/#{params['token']}?#{request.query_string}", 307

  sample_rate = 100 / params["rate"].to_i
  sample_rate = 1 if sample_rate < 0 || sample_rate > 100

  # to be more precise scale the rate
  sample_rate = (sample_rate * scale_factor).to_i

  call_number += 1
  call_number = 0 if call_number == scale_factor
  if (scale_factor * call_number % sample_rate == 0)
    redirect "http://requestb.in/14pfqnj1?/#{params['token']}?#{request.query_string}", 307
    #redirect "https://api.logmatic.io/v1/input/#{params['token']}?#{request.query_string}", 307
  else
    return "{\"ok\": \"dropped\"}"
  end
end