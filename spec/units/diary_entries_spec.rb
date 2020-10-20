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
  end
end
