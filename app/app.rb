ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require './app/data_mapper_setup'

class BookMarkManager < Sinatra::Base
  get '/links' do
    @links = Link.all
    erb(:links)
  end

  get '/links/new' do
    erb(:links_new)
  end

  post '/links' do
    @tag = Tag.first_or_create(name: params[:tags])
    @link = Link.create(title: params[:Title], url: params[:URL])
    @link.tags << @tag
    @link.save
    redirect '/links'
  end

  get '/tags/:tag' do
    @links = Link.all('tags.name': params[:tag])
    erb(:links)
  end


  run! if app_file ==$0
end
