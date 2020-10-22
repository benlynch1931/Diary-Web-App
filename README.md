CREATE TABLE diary (id SERIAL PRIMARY KEY, date DATE, title VARCHAR(100), body VARCHAR(1000));



UNIT - DiaryEntry: Red/Green ''



def self.print_entries
  @@diary_db = PG.connect dbname: 'diary_manager_test', user: 'ben'
  result = @@diary_db.exec("SELECT * FROM diary;")
  mapped = result.map { |entry| { date: (entry['date'].split('-').reverse.join('-')), title: entry['title'], body: entry['body']} }
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
