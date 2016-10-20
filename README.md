# logmatic-logplex-sampler
A simple ruby app that samples and forwards incoming events to Logmatic.io

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

## Usage
Once the app is deployed, you only need to setup a drain as follow:

```sh
heroku drains:add https://<your-logmatic-sampler>.herokuapp/<rate>/<your-api-key>
```

 * `<your-logmatic-sampler>` is your instance of logmatic-sampler
 * `<rate>` the sampling rate. Set to `10` for  10% and so on
 * `<your-api-key>` is your logmatic key
 

