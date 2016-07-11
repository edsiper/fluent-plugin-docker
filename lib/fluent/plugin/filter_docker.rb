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

require 'fluent/filter'
require 'fluent/plugin'
require 'yajl'

module Fluent
  class DockerFilter < Filter
    Plugin.register_filter('docker', self)

    def configure(conf)
      super
    end

    def filter(tag, time, record)
      if record.has_key?('log')
        log = record['log']
        if log[0] == '{' || log[0] == '['
          log_json = Yajl.load(log)
          record['log'] = log_json
        end
      else
        router.emit_error_event(tag, time, record, e)
      end
      record
    end
  end
end
