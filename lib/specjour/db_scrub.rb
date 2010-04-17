module Specjour
  module DbScrub
    extend self

    def scrub
      puts Dir.pwd
      load 'Rakefile'
      puts Rails::Configuration.new.database_configuration[Rails.env]
      connect_to_database
      if pending_migrations?
        puts "Migrating schema for database #{ENV['TEST_ENV_NUMBER'] || 1}..."
        Rake::Task['db:test:load'].invoke
      else
        purge_tables
      end
    end

    protected

    def connect_to_database
      ActiveRecord::Base.establish_connection Rails::Configuration.new.database_configuration[Rails.env]
      connection
    rescue # assume the database doesn't exist
      Rake::Task['db:create'].invoke
    end

    def connection
      ActiveRecord::Base.connection
    end

    def purge_tables
      connection.disable_referential_integrity do
        tables_to_purge.each do |table|
          connection.delete "delete from #{table}"
        end
      end
    end

    def pending_migrations?
      ActiveRecord::Migrator.new(:up, 'db/migrate').pending_migrations.any?
    end

    def tables_to_purge
      connection.tables - ['schema_migrations']
    end
  end
end
