# logmatic-sampler
A simple ruby app that samples and forwards incoming events

## Usage
Logmatic-sampler is a kind of a proxy for sampling logplex frames from heroku drains.
You only need to setup a drain as follow:

```sh
heroku drains:add https://<your-logmatic-sampler>.herokuapp/<rate>/<your-api-key>?appname=whatever&some_field=some_value
```

 * `<your-logmatic-sampler>` is your instance of logmatic-sampler
 * `<rate>` the sampling rate. Set to `10` for  10% and so on
 * `<your-api-key>` is your logmatic key
 
All query params are transfered to Logmatic.io as usual


## Installation
From the console:
```sh
git clone https://github.com/logmatic/logmatic-sampler
cd logmatic-sampler
heroku login
heroku create
git push heroku master
```

Or directly:
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/logmatic/logmatic-sampler)

## Support
Let write an email to support <at> logmatic.io