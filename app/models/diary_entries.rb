# frozen_string_literal: false

require 'pg'

# this class allows the creation and saving of diary entries
class DiaryEntry
  @@post = ""

  def initialize
    @entry_body = ''
    @entry_title = ''
    @entry_hash = {}
  end

  def add_entry
    puts 'to finish, press `enter` twice:'
    loop do
      @entry_input = gets.chomp
      if @entry_input == ''
        @entry_body.delete_suffix!("\n")
        break
      else
        @entry_body << "#{@entry_input}\n"
      end
    end
    # @entry_body = @entry_body.gsub("'", "''")
    @entry_body
  end

  def add_title
    @entry_title = gets.chomp
    # if @entry_title.include?("'")
      # @entry_title.gsub("'", "''")
    # else
      # @entry_title
    # end
  end

  def save_entry(entry_title: @entry_title, entry_body: @entry_body)
    if entry_body.empty? || entry_title.empty?
      puts 'Unable to save. Entry incomplete...'
    else
      @entry_hash[:date] = Time.now.strftime('%Y-%m-%d')
      puts @entry_hash[:date]
      @entry_hash[:title] = entry_title.gsub("'", "''")
      @entry_hash[:body] = entry_body.gsub("'", "''")
      @entry_hash
    end
  end

  # def save_entry_online(entry_title:, entry_body:)
  #     @entry_hash[:date] = Time.now.strftime('%Y%m%d')
  #     @entry_hash[:title] = :entry_title.to_s.gsub("'", "''")
  #     @entry_hash[:body] = :entry_body.to_s.gsub("'", "''")
  #     @entry_hash
  # end

  def add_to_db
    init_database
    @diary_db.exec "
      INSERT INTO diary(date, title, body)
      VALUES( '#{@entry_hash[:date]}', '#{@entry_hash[:title]}', '#{@entry_hash[:body]}');
      "
    @diary_db.close
    puts 'Successfully saved to diary'
  end

  def self.print_entries(conditions)
    if ENV["RACK_ENV"] == 'test'
      @@diary_db = PG.connect dbname: 'diary_manager_test', user: 'ben'
    else
      @@diary_db = PG.connect dbname: 'diary_manager', user: 'ben'
    end
    result = @@diary_db.exec("SELECT * FROM diary #{conditions};")
    mapped = result.map { |entry| { id: entry['id'], date: (entry['date'].split('-').reverse.join('-')), title: entry['title'], body: entry['body']} }
  end

  def self.allow_edit(post)
    @@post = post
  end

  def self.post
    @@post
  end

  def delete_entry(id_input:)
    init_database
    id_int = id_input.to_i
    puts id_int
    @diary_db.exec("DELETE FROM diary WHERE id=#{id_int}")
  end


  def init_database
    begin
      if ENV["RACK_ENV"] == 'test'
        @diary_db = PG.connect dbname: 'diary_manager_test', user: 'ben'
      else
        @diary_db = PG.connect dbname: 'diary_manager', user: 'ben'
      end
      puts 'Successfully Connected!'
    rescue PG::Error
      puts 'error loading database!'
    end
  end



end
