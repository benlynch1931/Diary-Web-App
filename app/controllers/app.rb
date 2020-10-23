# frozen_string_literal: true

require 'sinatra'
require './app/models/diary_entries.rb'

# This class controls the routes of the Diary Application
class DiaryApp < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :views, File.expand_path('../views', __dir__)
  set :public_folder, File.expand_path('../public', __dir__)
  enable :sessions
  set :session_secret, ENV["SESSION_SECRET"]

  get '/' do
    session[:date] = Date.today.strftime('%Y-%m-%d')
    session[:allow_edit] = nil
    erb :index
  end

  get '/add_entry' do
    erb :add_entry
  end

  post '/add_entry' do
    entry = DiaryEntry.new
    entry.save_entry(entry_title: params[:title_entry], entry_body: params[:body_entry])
    entry.add_to_db
    redirect '/'
  end

  post '/allow_edit' do
    session[:allow_edit] = params[:id]
    redirect '/day'
  end

  post '/allow_delete' do
    @delete = DiaryEntry.new
    @delete.delete_entry(id_input: params[:id])
    redirect '/day'
  end



  get '/week' do
    # @entries = DiaryEntry.print_entries("WHERE date BETWEEN #{Date.today.beginning_of_week.strftime('%Y%m%d')} AND #{(Date.today.end_of_week - 2.days).strftime('%Y%m%d')}")
    # erb :week
    redirect '/day'
  end

  get '/day' do
    @allow_edit = session[:allow_edit]
    @entries = DiaryEntry.print_entries("WHERE date='#{session[:date]}'")
    erb :day
  end

  post '/day/today' do
    session[:date] = Date.today.strftime('%Y-%m-%d')
    redirect '/day'
  end

  get '/month' do
    redirect '/day'
  end

  run! if app_file == $0
end
