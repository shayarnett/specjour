autoload :URI, 'uri'
autoload :DRb, 'drb'
autoload :Forwardable, 'forwardable'
autoload :GServer, 'gserver'

module Specjour
  autoload :Dispatcher, 'specjour/dispatcher'
  autoload :Manager, 'specjour/manager'
  autoload :RsyncDaemon, 'specjour/rsync_daemon'
  autoload :Printer, 'specjour/printer'
  autoload :Protocol, 'specjour/protocol'
  autoload :Worker, 'specjour/worker'

  autoload :Rspec, 'specjour/rspec'
  autoload :Cucumber, 'specjour/cucumber'

  VERSION = "0.1.9".freeze
end
