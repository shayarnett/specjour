require 'specjour'

namespace :specjour do
  task :dispatch, [:project_path] do |task, args|
    args.with_defaults :project_path => Rake.original_dir
    Specjour::Dispatcher.new(args.project_path).start
  end

  namespace :cucumber do
    task :dispatch, [:project_path] do |task, args|
      args.with_defaults :project_path => Rake.original_dir
      Specjour::Cucumber::Dispatcher.new(args.project_path).start
    end
  end

  desc "Dispatch the project to listening managers"
  task :cucumber => "cucumber:dispatch"
end

desc "Dispatch the project to listening managers"
task :specjour => "specjour:dispatch"
