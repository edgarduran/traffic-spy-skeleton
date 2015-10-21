module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    get '/sources/:identifier/data' do |identifier|
      @user = User.find_by({identifier: identifier})
      erb :data
    end

    get '/sources' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      user = User.new(params)
      if User.all.include?(User.find_by(params))
        status 403
        body "User already exists 403 - Bad Request"
      elsif user.save
        status 200
        body "Success - 200 OK"
      else
        status 400
        body user.errors.full_messages.join(", ")
      end
    end

    post '/sources/:identifier/data'  do |identifier|
      user = User.find_by(identifier: identifier)
      params = ParsePayload.parse(params)
      data = Payload.new(params)
      sha = Digest::SHA2.hexdigest('payload.to_s')
    end
  end
end
