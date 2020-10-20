require 'sinatra'
require './app/models/diary_entries.rb'

class DiaryApp < Sinatra::Base
  set :views, File.expand_path('../../views',__FILE__)
  set :public_folder, File.expand_path('../../public', __FILE__)
  set :root, File.dirname(__FILE__)
end
