ENV['RACK_ENV'] ||= 'development'

require "sinatra/base"
require_relative "./models/data_mapper_setup"

class BookMarkManager < Sinatra::Base
enable :sessions
set :sessions_secret, 'super sercret'

helpers do
  def current_user
    @current_user ||= User.get(session[:user_id])
  end
end


get '/users/new' do
  erb :'users/new'
end


post '/users' do
  user = User.create(user_name: params[:user_name], password: params[:password], password_confirmation: params[:password_confirmation], email: params[:email])
  #user.password_confirmation =  params[:password_confirmation]
  session[:user_id] = user.id
  redirect '/users'
end

get '/users' do
  erb :users
end

get '/links/new' do
  erb :new
end

post '/links' do
  link = Link.create(title: params[:title], url: params[:url])
  params[:tag].split(", ").each do | tag |
    tag = Tag.create(name: tag )
    link.tags << tag
    link.save
  end

  redirect '/links'
end

get '/links' do
  @links = Link.all
  erb :links
end

get '/tags/:tag' do
  @links = Link.all('tags.name' => params[:tag] )
  erb :links
end



  run! if app_file == $0
end
