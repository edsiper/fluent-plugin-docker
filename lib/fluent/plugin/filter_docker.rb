#
# Fluentd
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#

require 'yajl'
require 'fluent/filter'
require 'fluent/plugin'

module Fluent
  class DockerFilter < Filter
    Plugin.register_filter('docker', self)
    attr_reader :log_key # for tests

    config_param :symbolize_names, :bool, default: false,
                 desc: "For testing purpose. You should set false."

    def initialize
      super
    end

    def configure(conf)
      super
      @log_key = if @symbolize_names
        :log
      else
        "log"
      end
    end

    def filter(tag, time, record)
      if record.has_key?("log") || record.has_key?(:log)
        log = record["log"] || record[:log]
        if log[0] == '{' || log[0] == '['
          log_json = Yajl.load(log, {:symbolize_names => @symbolize_names})
          record[@log_key] = log_json
        end
      end
      record
    end
  end
end
