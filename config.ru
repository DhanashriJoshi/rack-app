require_relative 'search_user_api'

use Rack::Reloader, 0

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == ['admin', 'secret']
end

run SearchUserApi
