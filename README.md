


# TITLE

## Setup

### 1. Forking and Cloning the repository
- Begin by forking the repo, then cloning it to your local machine

### 2. Installing necessary gems:
- In terminal, run: <br>
`% bundle install` <br>

### 3. Creating Test Environment Database:
- Open terminal and run: <br>
`% brew install postgresql`<br>
`% psql ` <br>
`# CREATE DATABASE diary_manager_test ` <br>
`# \q` <br>
`% psql diary_manager_test -f 01_creating_test_table.sql` <br>


### 4. Creating Development Environment Databse:
- Open terminal and run: <br>
`% psql ` <br>
`# CREATE DATABASE diary_manager ` <br>
`# \q` <br>
`% psql diary_manager -f 02_creating_development_table.sql` <br>

### 5. Changing `User`: 
- In `spec/units/bookmark_spec.rb` update `USER` to equal _your_ user.


### 6. Running Server and Accessing Web App:
- In terminal run: <br>
`% shotgun --port=6030`
- Go to your browser and type this in the URL: <br>
`localhost:6030`


CREATE TABLE diary (id SERIAL PRIMARY KEY, date DATE, title VARCHAR(100), body VARCHAR(1000));



UNIT - DiaryEntry: Red/Green ''
