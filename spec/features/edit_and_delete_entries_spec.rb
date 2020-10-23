feature "User can edit and delete single posts at a time" do
  scenario "All posts show with an edit button" do
    set_table
    @entries = DiaryEntry.print_entries("")
    visit('/day')
    expect(page).to have_button('edit', count: @entries.length)
  end
end
