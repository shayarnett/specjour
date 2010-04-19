module Specjour
  require 'thor'
  class CLI < Thor
    default_task :dispatch

    def self.printable_tasks
      super.reject{|t| t.last =~ /INTERNAL USE/ }
    end

    def self.worker_option
      method_option :workers, :aliases => "-w", :type => :numeric, :desc => "Number of concurent processes to run. Defaults to your system's available cores."
    end

    class_option :log, :aliases => "-l", :type => :boolean, :desc => "Print debug messages to $stdout"

    desc "listen", "Advertise availability to run specs"
    worker_option
    method_option :projects, :aliases => "-p", :type => :array, :desc => "Projects supported by this listener"
    def listen
      handle_logging
      handle_workers
      Specjour::Manager.new(args).start
    end

    desc "dispatch [PROJECT_PATH]", "Run specs in this project"
    worker_option
    method_option :alias, :aliases => "-a", :desc => "Project name advertised to listeners"
    def dispatch(path = Dir.pwd)
      handle_logging
      handle_workers
      args[:project_path] = path
      Specjour::Dispatcher.new(args).start
    end

    desc "version", "Show the version of specjour"
    def version
      puts Specjour::VERSION
    end

    desc "work", "INTERNAL USE ONLY"
    method_option :project_path, :required => true
    method_option :printer_uri, :required => true
    method_option :number, :type => :numeric, :required => true
    def work
      Specjour::Worker.new(args).start
    end

    protected

    def args
      @args ||= options.dup
    end

    def handle_logging
      Specjour.new_logger(Logger::DEBUG) if options['log']
    end

    def handle_workers
      args["worker_size"] = options["workers"] || CPU.cores
    end
  end
end