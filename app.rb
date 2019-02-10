require 'dotenv'

Dotenv.load('.env.local', '.env')

require 'json'
require 'net/http'
require 'oauth2'
require "sinatra/reloader"
require 'sinatra/base'
require 'pry'

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    enable :sessions
  end

  def client_id
    ENV['STATUSGATOR_OAUTH_ID']
  end

  def client_secret
    ENV['STATUSGATOR_OAUTH_SECRET']
  end

  def oauth_url
    ENV['STATUSGATOR_OAUTH_URL']
  end

  def client
    @client ||= OAuth2::Client.new(client_id, client_secret, :site => oauth_url)
  end

  def authorize_url
    client.auth_code.authorize_url(:redirect_uri => 'http://localhost:9292/oauth/callback')
  end

  def token
    client.auth_code.get_token(params[:code], :redirect_uri => 'http://localhost:9292/oauth/callback').token
  end

  def ping
    uri = URI("#{ENV['STATUSGATOR_API_ROOT']}/api/v1/ping")
    req = Net::HTTP::Get.new(uri)
    req['Authorization'] = "Bearer #{session['token']}"

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(req)
    end

    if res.code == "200"
      res.body
    end
  end


  get '/' do
    if text = ping
      text
    else
      redirect authorize_url
    end
  end

  get '/oauth/callback' do
    session['token'] = token
    redirect '/'
  end


  run! if app_file == $0
end

__END__


# client.auth_code.authorize_url(:redirect_uri => 'http://localhost:8080/oauth2/callback')
# =>
# "https://example.org/oauth/authorization?response_type=code&client_id=client_id&redirect_uri=http://localhost:8080/oauth2/callback"
#
# token = client.auth_code.get_token('authorization_code_value', :redirect_uri
# => 'http://localhost:8080/oauth2/callback', :headers => {'Authorization' =>
# 'Basic some_password'})
# response = token.get('/api/resource', :params => { 'query_foo' => 'bar' })
# response.class.name
# # => OAuth2::Response
