# frozen_string_literal: true

require 'sinatra'
require './app/models/diary_entries.rb'

# This class controls the routes of the Diary Application
class DiaryApp < Sinatra::Base
  set :views, File.expand_path('../../views', __dir__)
  set :public_folder, File.expand_path('../../public', __dir__)
  set :root, File.dirname(__FILE__)
end
