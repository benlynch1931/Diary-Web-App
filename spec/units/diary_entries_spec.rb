# frozen_string_literal: true

require './app/models/diary_entries.rb'
require './spec/web_helpers.rb'

describe DiaryEntry do
  before do
    set_table
  end
  # I know it is bad English, it is just there for testing purposes!
  multi_line_entry = "My first entry''s here\nline 2 of entry\nfinal line of entry here..."
  single_line_entry = 'My first entry'
  date = Time.now.strftime('%Y%m%d')

  context ' #initialize' do
    subject(:diary_entry) { DiaryEntry.new }

    it 'instantiates DiaryEntry' do
      expect(diary_entry).to be_a DiaryEntry
    end
  end

  context ' #add_entry' do
    subject(:diary_entry) { DiaryEntry.new }

    it 'responds to call' do
      expect(diary_entry).to respond_to(:add_entry)
    end

    it 'saves user entry to variable' do
      allow(diary_entry).to receive(:gets).and_return('My first entry', '')
      expect(diary_entry.add_entry).to eq single_line_entry
    end

    it 'allows user to enter multiple line entries' do
      allowing_spec
      expect(diary_entry.add_entry).to eq multi_line_entry
    end

    it 'formats any apostrophes to begin with a backslash' do
      allowing_spec
      expect(diary_entry.add_entry).to eq multi_line_entry
    end
  end

  context ' #add_title' do
    subject(:diary_entry) { DiaryEntry.new }

    it 'responds to call' do
      expect(diary_entry).to respond_to(:add_title)
    end

    it 'saves user entry to variable' do
      allow(diary_entry).to receive(:gets).and_return('First Entry')
      expect(diary_entry.add_title).to eq 'First Entry'
    end

    it 'formats any apostrophes to begin with a backslash' do
      allow(diary_entry).to receive(:gets).and_return("First Entry's")
      expect(diary_entry.add_title).to eq "First Entry''s"
    end
  end

  context ' #save_entry' do
    subject(:diary_entry) { DiaryEntry.new }

    it 'repsonds to call' do
      expect(diary_entry).to respond_to(:save_entry)
    end

    it 'creates hash of entry data' do
      title = 'Title of First Entry'
      add_entries_spec
      expect(diary_entry.save_entry).to eq({ date: date, title: title, body: multi_line_entry })
    end
  end

  context ' #add_to_db' do
    subject(:diary_entry) { DiaryEntry.new }

    it 'responds to call' do
      expect(diary_entry).to respond_to(:add_to_db)
    end

    it ' #init_database successfully connects to the database' do
      expect { diary_entry.init_database }.to output("Successfully Connected!\n").to_stdout
    end

    it 'executes INSERT query' do
      add_entries_spec
      diary_entry.save_entry
      expect { diary_entry.add_to_db }.to output("Successfully Connected!\nSuccessfully saved to diary\n").to_stdout
    end
  end

  context ' #print_entries' do
    subject(:diary_entry) { DiaryEntry.new }
    it "returns all entries" do
      set_table
      add_to_print_entry
      diary_entry.add_to_db
      expect(DiaryEntry.print_entries).to eq([{date: '22-10-2020', title: 'Test Title', body: 'Test Body'}])
    end
  end
end
