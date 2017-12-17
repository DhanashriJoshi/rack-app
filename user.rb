require_relative 'mysql_connection_service'
require_relative 'responder'

class User
  attr_accessor :search_pattern

  def initialize(params)
    @search_pattern = params['search_pattern']
  end

  def call
    if (@search_pattern != nil) && (@search_pattern != '')
      s = MysqlConnectionService.new._query("select * from users where name like '%#{@search_pattern}%'")
      obj = s.map{|u| {name: u['name'], contact_no: u['contact_no'],  email: u["email"]}}
      get_response('User fetched Successfully', 200, obj)
    else
      return get_response('Bad Request', 400, nil)
    end
  end

  def get_response(message=nil, code=200, objects=nil)
    Responder.new(message, code, objects).response
  end
end
