use christila;

# no need to specifically tell which columns to enter data
# if you passing data to all columns of a table
insert into height
values ("christila", 60.3, "f");

# if you passing data into subset of columns of a table
# need to specify which columns you want to enter data
insert into height (name, sex)
values ("ashen", "m");

# when it come to inserting data into tables, we can
# use single insert statement,
insert into height
values ("ishari", 89.9, "f"),
       ("ishari", 89.9, "f");

# or we can use multiple statements,
insert into height
values ("perera", 11.0, "f");
insert into height
values ("subodhi", 11.9, "f");

# if you use single insert command if there is
# a error while executing all the data will
# not insert into table
insert into height (name, height)
values ("christila_1", 21.8),
       ("christila_2", 22.8),
       ("christila_3", 23.8),
       ("christila_4", 24.8),
       ("christila_5", 25.8),
       ("christila_6", 26.8),
       ("christila_7", "121.8"),
       ("christila_8", 20.8),
       ("christila_9", 20.8),
       ("christila_10", 20.8),
       ("christila_11", 20.8),
       ("christila_12", 20.8);

# in here if there was error all the data before
# error occurred was inserted to table
insert into height (name, height) values ("christila_1", 21.8);
insert into height (name, height) values ("christila_2", 22.8);
insert into height (name, height) values ("christila_3", 23.8);
insert into height (name, height) values ("christila_4", 24.8);
insert into height (name, height) values ("christila_5", 25.8);
insert into height (name, height) values ("christila_6", 26.8);
insert into height (name, height) values ("christila_7", "121.8");
insert into height (name, height) values ("christila_8", 20.8);
insert into height (name, height) values ("christila_9", 20.8);
insert into height (name, height) values ("christila_10", 20.8);
insert into height (name, height) values ("christila_11", 20.8);
insert into height (name, height) values ("christila_12", 20.8);