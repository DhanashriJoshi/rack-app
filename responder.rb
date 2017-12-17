class Responder
  class ErroredResponse < StandardError; end
  
  attr_accessor :message, :body, :code, :head

  def initialize(message, code=200, body=nil)
    self.message = message
    self.code = code
    self.body = body

    if code == 200
      self.head = {"code" => code}
    else
      self.head = {"message" => message, "code" => code}
    end
  end

  def response
    {
      head: head,
      body: body
    }.to_json
  end

  def self.respond_to_json(code, contents, head={})
    if code == 304
      header = {}
    else
      header = {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
    end
    [ code,
      header.merge(head),
      [contents]
    ]
  end
end
