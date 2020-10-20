require "./app/models/diary_entries.rb"

describe DiaryEntry do

  context '#initialize' do
    subject(:diary_entry) { DiaryEntry.new }

    it "instantiates DiaryEntry" do
      expect(diary_entry).to be_a DiaryEntry
    end
  end

  context '#add_entry' do
    subject(:diary_entry) { DiaryEntry.new }

    it "responds to call" do
      expect(diary_entry).to respond_to(:add_entry)
    end

    it "saves user entry to variable" do
      allow_any_instance_of(DiaryEntry).to receive(:gets).and_return("My first entry", '')
      entry = "My first entry"
      expect(diary_entry.add_entry).to eq entry
    end

    it "allows user to enter multiple line entries" do
      allow(diary_entry).to receive(:gets).and_return("My first entry", "line 2 of entry", "final line of entry here...", "")
      entry = "My first entry\nline 2 of entry\nfinal line of entry here..."
      expect(diary_entry.add_entry).to eq entry
    end
  end

  context '#add_title' do
    subject(:diary_entry) { DiaryEntry.new }

    it "responds to call" do
      expect(diary_entry).to respond_to(:add_title)
    end

    it "saves user entry to variable" do
      allow(diary_entry).to receive(:gets).and_return("First Entry")
      expect(diary_entry.add_title).to eq "First Entry"
    end
  end

  context '#save_entry' do
    subject(:diary_entry) { DiaryEntry.new }

    it 'repsonds to call' do
      expect(diary_entry).to respond_to(:save_entry)
    end

    it 'creates hash of entry data' do
      body = "My first entry\nline 2 of entry\nfinal line of entry here..."
      title = "Title of First Entry"
      date = ""
      allow(diary_entry).to receive(:gets).and_return("My first entry", "line 2 of entry", "final line of entry here...", "", "Title of First Entry")
      diary_entry.add_entry
      diary_entry.add_title
      expect(diary_entry.save_entry).to eq ({date: Time.now.strftime("%d/%m/%Y"), title: title, body: body})
    end
  end

  context '#add_to_db' do
    subject(:diary_entry) { DiaryEntry.new }

    it 'responds to call' do
      expect(diary_entry).to respond_to(:add_to_db)
    end

    it 'successfully connects to the database' do
      expect { diary_entry.add_to_db }.to output("Successfully Connected!\n").to_stdout
    end
  end
end
