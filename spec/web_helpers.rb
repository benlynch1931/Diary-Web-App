def add_entries_spec
  allow(diary_entry).to receive(:gets).and_return(
    "My first entry's here", 'line 2 of entry', 'final line of entry here...', '', 'Title of First Entry'
  )
  diary_entry.add_entry
  diary_entry.add_title
end

def add_to_print_entry
  allow(diary_entry).to receive(:gets).and_return('Test Body', '', 'Test Title')
  diary_entry.add_entry
  diary_entry.add_title
  diary_entry.save_entry
end

def allowing_spec
  allow(diary_entry).to receive(:gets).and_return(
    "My first entry's here", 'line 2 of entry', 'final line of entry here...', '', 'Titles of First Entry'
  )
end

def set_table
  db = PG.connect(dbname: 'diary_manager_test')
  db.exec("TRUNCATE TABLE diary;")
end
