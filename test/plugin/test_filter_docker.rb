require 'helper'

class DockerFilterTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  CONFIG = %[
    symbolize_names false
  ]

  def create_driver(conf=CONFIG)
    Fluent::Test::FilterTestDriver.new(Fluent::DockerFilter).configure(conf)
  end

  class LogLeyTest < self
    def test_string_log_key
      d = create_driver(%[symbolize_names false])
      assert_false d.instance.symbolize_names
      assert_equal "log", d.instance.log_key
    end

    def test_symbol_log_key
      d = create_driver(%[symbolize_names true])
      assert_true d.instance.symbolize_names
      assert_equal :log, d.instance.log_key
    end
  end

  def test_filter
    d = create_driver(%[symbolize_names true])
    record = {"source":"stdout","log":"{\"msg\":12345}","container_id":"d6baf71","container_name":"/furious_babbage"}
    expected = {"source":"stdout","log":{"msg":12345},"container_id":"d6baf71","container_name":"/furious_babbage"}
    d.emit(record)
    d.run
    emits = d.emits
    assert_equal expected, emits.map{|e| e.last}.first
  end
end
