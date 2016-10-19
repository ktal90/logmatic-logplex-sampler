require 'sinatra'

call_number = 0
scale_factor = 1000
post '/sampler/:rate/:token' do

  sample_rate = 100 / params["rate"].to_i
  sample_rate = 1 if sample_rate < 0 || sample_rate > 100

  # to be more precise scale the rate
  sample_rate = (sample_rate * scale_factor).to_i

  call_number += 1
  call_number = 0 if call_number == scale_factor
  if (scale_factor * call_number % sample_rate == 0)
    redirect "https://api.logmatic.io/v1/input/#{params['token']}?#{request.query_string}", 307
  else
    return "{\"ok\": \"dropped\"}"
  end
end