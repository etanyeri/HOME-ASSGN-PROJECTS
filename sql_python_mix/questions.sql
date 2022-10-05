/*

Provider Table
    provider_id	        provider_name	            Created
        1	                John Smith	        3/4/2009 12:45:00
        2	                Michael Rowe	    5/3/2010 15:34:34
        3	                Gregory Adams	    4/5/2011 23:44:59


Profession Table
profession_id	    Profession_degree
    1	                DO
    2	                MD



provider_profession table
provider_id	                        profession_id
    1	                                    1
    1	                                    2
    2	                                    2
    3	                                    1
    3	                                    2



Provider_practice table
Provider_practice_id	             Provider_id            	City

        1	                            1	                  Morristown
        2	                            2	                   Passaic
        3	                            2	                   Jersey City
        4	                            1	                    Trenton
        5	                            2	                    East Rutherford
        6	                            3	                   Rutherford
        7	                            1	                   Lyndhurst
		


Queries
Please write a SQL query to satisfy the following:.
1.	 List all the providers, ordered by provider name. While outputting the names of all the providers, if the name of the provider contains the word ‘John’, output ‘Johnathan’ instead of ‘John’ within the same output field of provider_name.


2.	List out the degrees and the counts that are associated to the degree.  If the degree is listed more than twice, output ‘Popular degree’. 


3.	How many providers have a profession of DO and is associated with a city that contains ‘er’ in its name?

4.	List all providers with their profession code created after April of 2010 and is associated with a city that has more than one word in the name.

5.	Roger has a list of doctors on a csv file.  The file contains a column called “provider_id”.  He would like to compare that file against the provider table and see what provider_id does not exist.  How would you bring the file in the database and what query would you use on the comparison? 

6.	Sally is looking for a doctor who lives near her town in the Rutherford area and knows she a couple of options.  Write a query that will list the doctors in her town using a single where clause.  


7.	John has come to you and noticed some of the query performance he is experiencing is extremely slow.  How would you approach this situation to figure out the performance issue? 


8.	Write an index using the query you compiled in question 5.


9.	You have decided to delete doctors that contained the name ‘John’ in their name.  You have a function in the lib schema called item_remove where the first item in the function is the table and the second item is the provider_id.  Write a shell script that will connect to the database and loop through the provider_id into the function.  

10.	 Create a shell script that contains a variable called “pg_con” which will connect to postgresql and write a sql statement using the sql from question 3 against the variable that output just the value and nothing else.  

*/