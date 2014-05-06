## Fans Home

This is the source code of [Fans Home](http://***.***) website.

## Requirements

* Ruby 1.9.3 +

## Install

```bash
git clone https://github.com/1018512841/fans-home.git
cd fans-home

rails s
```

## Gemfile Source

By default bundler installs gems using the ruby.taobao.org source, if you'd rather use the official one, set environment variable `USE_OFFICIAL_GEM_SOURCE`:

```
USE_OFFICIAL_GEM_SOURCE=1
```


## Testing

```bash
bundle exec rspec spec
```

to prepare all the config files and start essential services.
