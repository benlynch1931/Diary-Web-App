class DiaryEntry

  def initialize
    @entry_body = ""

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
end
