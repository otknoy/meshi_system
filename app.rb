#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'sinatra/base'
require 'sinatra/reloader'
require 'date'

require './database.rb'

db_filename = './data/db.json'
$database = Database.new(db_filename)

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    @title = 'メシいこ！'
    @shops = ['いち花', '喜楽', 'ほかなに？']

    @data = $database.read

    erb :index
  end

  post '/new' do
    date = params[:date]
    where = params[:where]

    $database.add(date, where)

    # @test = date + where
    # erb :test
    redirect '/'
  end
end

App.run! :host => 'localhost', :port => 9090
