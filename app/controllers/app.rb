# frozen_string_literal: true

require 'sinatra'
require './app/models/diary_entries.rb'

# This class controls the routes of the Diary Application
class DiaryApp < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :views, File.expand_path('../views', __dir__)
  set :public_folder, File.expand_path('../public', __dir__)



  get '/week' do
    # @entries = DiaryEntry.print_entries("WHERE date BETWEEN #{Date.today.beginning_of_week.strftime('%Y%m%d')} AND #{(Date.today.end_of_week - 2.days).strftime('%Y%m%d')}")
    # erb :week
    redirect '/day'
  end

  get '/day' do
    @entries = DiaryEntry.print_entries("")
    erb :day
  end

  get '/month' do
    redirect '/day'
  end

  run! if app_file == $0
end
