# fluent-plugin-docker

This _Gem_ is a [Fluentd](http://fluentd.org) plugin filter that helps to manager [Docker](http://www.docker.com) logs. When enabled, it main functionality is to check and convert quoted JSON _log_ messages into real JSON format, e.g:

From

```
{"source":"stdout","log":"{\"msg\":12345}","container_id":"d6baf71","container_name":"/furious_babbage"}
```

to

```
{"source":"stdout","log":{"msg":12345},"container_id":"d6baf71","container_name":"/furious_babbage"}
```

## Installation

### Native gem

$ gem install fluent-plugin-docker

### Fluentd gem

$ fluent-gem install fluent-plugin-docker

## Usage

In your Fluentd configuration file, the Docker plugin filter can be used as follows:

```
<source>
  type forward
  port 24224
  bind 0.0.0.0
</source>

<filter docker.**>
  type docker
</filter>

<match **>
  type stdout
</match>
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/edsiper/fluent-plugin-docker.

## License

The gem is available as open source under the terms of the [Apache v2 License](http://www.apache.org/licenses/LICENSE-2.0)
