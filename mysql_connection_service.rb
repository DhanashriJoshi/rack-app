require 'json'
require 'mysql2'

class MysqlConnectionService
  def initialize
    @client = Mysql2::Client.new(
      :host => "localhost",
      :database => "rack_app",
      :username => "root",
      :password => nil
    )
  end

  def call(env)
    results = _query(sql)
  end

  def _query(sql)
    results = @client.query(sql)
  end
end
