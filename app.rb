#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'sinatra/base'
require 'sinatra/reloader'

require 'active_record'
require 'logger'


ActiveRecord::Base.establish_connection('adapter' => 'sqlite3',
                                        'database' => './data/posts.sqlite')

ActiveRecord::Base.logger = Logger.new(STDOUT)

class Post < ActiveRecord::Base
end


class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    @title = '「メシ行こ」支援システム (仮)'
    @places = ['いち花', '喜楽', 'ほげほげ']

    @data = Post.all

    erb :index
  end

  post '/new' do
    date = params[:date]
    place = params[:place]
  
    # post = Post.new(:date => date, :shop => shop, :like_count => 0)
    post = Post.new(:date => date, :place => place, :like_count => 0)  
    post.save

    redirect '/'

    # @test = Post.methods
    # @test = shop
    # erb :test
  end
end

App.run! :host => 'localhost', :port => 9090
