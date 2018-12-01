# bash-assignment-Database Management Server

The DBMS allows a client to create a database, create a table in that database, insert data into tables and to select data to review.

# Run the server script to handle the commands

./server.sh

# Run the client script with a client ID. Within this script commands can be inserted for execution by the server

./client.sh ID

# Command scripts can be run outside of the server

# Create a database with a unique database name

./create_database.sh DATABASENAME

# Create a table with an existing database name, unique table name and headings for columns, separated by columns with no spaces

./create_table.sh DATABASENAME TABLENAME HEADING1,HEADING2,HEADING3

# Insert data into a table by specifying an existing database, an existing table and data to be inserted - this data must be of the same number as the headings

./insert.sh DATABASENAME TABLENAME INSERT1,INSERT2,INSERT3

# Select rows and columns from an existing table in an existing database. This can be done in several ways.

    # Select all columns and rows from an existing table

    ./select.sh DATABASENAME TABLENAME

    # Select specific columns from an existing table

    ./select.sh DATABASENAME TABLENAME 1,3

    # Select specific rows from all the columns in an existing table based on a WHERE clause that matches a value. WHERE is expressed as a column number and rows that match the value will be returned.

    ./select.sh DATABASENAME TABLENAME 1 VALUE

     # Select specific rows from selected columns in an existing table based on a WHERE clause that matches a value. WHERE is expressed as a column number and rows that match the value will be returned.

     ./select.sh DATABASENAME TABLENAME 1,3 1 VALUE

# Clean allows quick removal of any locks, pipes or background servers/clients

./clean.sh