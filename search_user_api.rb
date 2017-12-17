require_relative 'user'
require_relative 'responder'

class SearchUserApi
  def self.call(env)
    new(env).response
  end

  def initialize(env)
    @env = env
    @request = Rack::Request.new(env)
  end

  def response
    begin
      case @request.path
      when "/" then Rack::Response.new(render("index.html.erb"))
      when "/users"
        check_request
      else Rack::Response.new("Page Not Found", 404)
      end
    rescue Exception => e
      handle_exception(e.message)
    end
  end

  def check_request
    headers = @env.select {|k,v| k.start_with? 'HTTP_'}.collect{|key, val| [key.sub(/^HTTP_/, ''), val]}.to_h
    begin
      params = @request.params
      case @request.request_method
      when 'POST'
        Rack::Response.new("Post Method is currently not started", 200)
      when 'GET'
        if !headers.has_key?('ETag')
          parts = []
          body = User.new(params).call
          head = {}
          head['ETag'] = %("#{Digest::MD5.hexdigest(body)}")
        end
        if headers['IF_NONE_MATCH'] == head['ETag']
          Responder.respond_to_json(304, 'Not Modified')
        else
          Responder.respond_to_json(200, body, head)
        end
      else
        Responder.respond_to_json(404, 'Page not found')
      end
    rescue Exception => e
      handle_exception(e)
    end
  end

  def render(template)
    path = File.expand_path("../views/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end

  def handle_exception(error)
    Responder.respond_to_json(500, error.message)
  end
end
