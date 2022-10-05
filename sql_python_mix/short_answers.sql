

/*

5.Roger has a list of doctors on a csv file.  The file contains a column called “provider_id”.  He would like to compare that file against the provider table and see what provider_id does not exist.  How would you bring the file in the database and what query would you use on the comparison? 
Before I move forward with performing the PostgreSQL Import CSV job, I needed to ensure the following 2 aspects:


1.	A CSV file containing data that needs to be imported into PostgreSQL.                                                                          
2.	A table in PostgreSQL with a well-defined structure which has necessary columns o store the CSV file data accordingly.
I have created a file called ‘zelis.csv’ which includes some values of ‘provider_id’ field. I have saved it in     
      PG Admin folder not to have permission or security issues while reading the file.
      I also have created a table called ‘new_provider_data’ within Postgres so I could import my csv file into it.    
            While creating the table, I made sure that I have ‘provider_id’ column with right data type and values.


And then, I did run the following command to perform the PostgreSQL Import CSV job:
*/

copy new_provider_data
from '/Applications/PostgreSQL 14/zelis.csv'
delimiter ','
csv header;


/*
On successful execution of PostgreSQL Import CSV job, the Output “COPY 6” is displayed meaning that 6 records have been added to our PostgreSQL table.

    After importing new datas to the database, I have created the script against the provider table that will bring what provider_id does not exist in ‘provider’ table.

*/

select new_csv.provider_id
from new_csv
left join provider
  on new_csv.provider_id = provider.provider_id
where provider.provider_id is null




--Terminal also could be used the import the file;

psql -d your_dbname --user=db_username -c "COPY tbname FROM '/tmp/the_file.csv' delimiter '|' csv;"




/*

7.John has come to you and noticed some of the query performance he is experiencing is extremely slow.  How would you approach 
this situation to figure out the performance issue? 

I would first look at the indexes of the tables. Index is a search guide that we can add to our table that helps the server 
find the data it wants faster. It acts as an appendix to a book. Without these guides, the process of finding a particular topic/data 
would take way longer. The data server must literally read every row in the columns to find the expected value. By using indexes, 
we can rapidly speed up queries, so we do not have to experience poor performance. When we create an index, the database will generate 
a method to rapidly find data based on one or more columns. As long as the index we created is inside our select statement, performance 
would definitely be much better. Otherwise, without using  column/s of index, performance will stay at the same level.

There are two types of indexing called 'Cluster' and 'Non-Cluster'. The clustered index determines how the data is stored in 
the table by rearranging, organizing the data in the column. A table can have only one clustered index, but a clustered index can 
contain multiple columns in called a Compound Clustered Index. Not all data servers have a non-cluster indexing option.

Second, I would look at the database's schema design as to whether the tables need normalization for the performance issue.
 I would get rid of all the redundant data and find a way to store that data in a different table more efficiently. 
 Particular attention should be paid to defining the primary and foreign keys of the tables. All keys must be unique and not null. 
 Choosing the best data types will also have an impact on performances If normalizations are good, I would go for a functional 
 denormalization which means optimized queries, aggregations or join tables. Building a great relationships between table is 
 a crucial act in data modeling. 

*/




/*

8.Write an index using the query you compiled in question 5.

*/

 create index provider_first_last_name_idx

   on new_provider_data(first_name,last_name)





/*
9.You have decided to delete doctors that contained the name ‘John’ in their name.  You have a function in the lib schema 
called item_remove where the first item in the function is the table and the second item is the provider_id.  Write a shell 
script that will connect to the database and loop through the provider_id into the function.  


This is the my Postgres Function that removes the row that pecified by ‘ provider_id’.

*/

create or replace function item_remove(tbl_name text, prov_id integer)
returns void as $$
begin

   EXECUTE format('delete from %s WHERE provider_id = %s ',tbl_name,prov_id);

end;

$$ language plpgsql;

select item_remove('provider',3);


