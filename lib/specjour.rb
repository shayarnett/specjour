autoload :URI, 'uri'
autoload :DRb, 'drb'
autoload :Forwardable, 'forwardable'
autoload :GServer, 'gserver'

module Specjour
  autoload :Dispatcher, 'specjour/dispatcher'
  autoload :Manager, 'specjour/manager'
  autoload :RsyncDaemon, 'specjour/rsync_daemon'
  autoload :Worker, 'specjour/worker'
  autoload :Printer, 'specjour/printer'
  autoload :Protocol, 'specjour/protocol'

  module Rspec
    require 'spec'
    require 'spec/runner/formatter/base_text_formatter'

    autoload :DistributedFormatter, 'specjour/rspec/distributed_formatter'
    autoload :FinalReport, 'specjour/rspec/final_report'
    autoload :MarshalableFailureFormatter, 'specjour/rspec/marshalable_failure_formatter'
  end

  module Cucumber
    require 'cucumber'
    autoload :DistributedFormatter, 'specjour/cucumber/distributed_formatter'
  end

  VERSION = "0.1.9".freeze
end
