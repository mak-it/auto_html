module FixtureSetup
  def setup
    fixtures_dir = File.dirname(__FILE__) + '/fixtures'
    ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
    ActiveRecord::Migration.verbose = false
    load "#{fixtures_dir}/schema.rb"
  end
end