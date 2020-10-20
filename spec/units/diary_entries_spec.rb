require "./app/models/diary_entries.rb"

describe DiaryEntry do

  context '#initialize' do
    subject(:diary_entry) { DiaryEntry.new }
    it "instantiates DiaryEntry" do
      expect(diary_entry).to be_a DiaryEntry
    end
  end
end
