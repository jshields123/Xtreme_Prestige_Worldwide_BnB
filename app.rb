
require_relative './lib/users'
require 'sinatra/base'
require './lib/listing.rb'
require './lib/booking.rb'
require './database_connection_setup'

class XtremeBnB < Sinatra::Base
  enable :sessions

  get '/' do
    redirect '/listings'
  end

  get '/listings' do
    @user = Users.find(id: session[:user_id])
    @listings = Listing.all
    erb :index
  end

  get '/users/new' do
    erb :"users/new"
  end

  post '/users' do
    user = Users.create(name: params['name'], email: params['email'], password: params['password'])
    session[:user_id] = user.id
    redirect '/listings'
  end

  get '/sessions/new' do
    erb :"sessions/new"
  end

  post '/sessions' do
    user = Users.authenticate(email: params[:email], password: params[:password])
    session[:user_id] = user.id 
    redirect '/listings'

  get '/book-listing' do
    "Your booking is confirmed"

  end

  run! if app_file == $0

end
