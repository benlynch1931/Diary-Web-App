require 'time'
require 'pg'

class DiaryEntry

  def initialize
    @entry_body = ""
    @entry_title = ""
    @entry_hash  ={}

  end

  def add_entry
    puts "to finish, press `enter` twice:"
    while true
      @entry_input = gets.chomp
      if @entry_input == ''
        @entry_body.delete_suffix!("\n")
        break
      else
        @entry_body << "#{@entry_input}\n"
      end
    end
    @entry_body
  end

  def add_title
    @entry_title = gets.chomp
  end

  def save_entry
    if @entry_body.empty? || @entry_title.empty?
      puts "Unable to save. Entry incomplete..."
    else
      @entry_hash[:date] = Time.now.strftime("%d/%m/%Y")
      @entry_hash[:title] = @entry_title
      @entry_hash[:body] = @entry_body
      @entry_hash
    end
  end

  def add_to_db

    begin
      @diary_db = PG.connect :dbname => 'diary_manager', :user => 'ben'
      puts "Successfully Connected!"

    rescue PG::Error
      puts "error loading database!"

    #ensure
      #@bookmark_db.close if @bookmark_db
    end
  end
end
