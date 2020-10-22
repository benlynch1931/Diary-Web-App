# frozen_string_literal: true

require 'sinatra'
require './app/models/diary_entries.rb'

# This class controls the routes of the Diary Application
class DiaryApp < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :views, File.expand_path('../views', __dir__)
  set :public_folder, File.expand_path('../public', __dir__)



  get '/week' do
    diary_entry = DiaryEntry.new
    @entries = diary_entry.print_entries
    erb :week
  end

  run! if app_file == $0
end
