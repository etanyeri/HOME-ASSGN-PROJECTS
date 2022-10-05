

"""
9.You have decided to delete doctors that contained the name ‘John’ in their name.  You have a function in the lib schema 
called item_remove where the first item in the function is the table and the second item is the provider_id.  Write a shell 
script that will connect to the database and loop through the provider_id into the function.  


This is the my Postgres Function that removes the row that pecified by ‘ provider_id’.


create or replace function item_remove(tbl_name text, prov_id integer)
returns void as $$
begin

   EXECUTE format('delete from %s WHERE provider_id = %s ',tbl_name,prov_id);

end;

$$ language plpgsql;

select item_remove('provider',3);

"""


#==============================================
# IMPORT MODULES TO CONNECT TO POSTGRES DATABASE
#=================================================
import psycopg2
from allconfigs.configs import psql_config  

#=================================================
# CONNECTING TO AN EXISTING POSTGRES DATABASE
#=================================================
connection = psycopg2.connect(user= psql_config['postgres']['user'],
                              password = psql_config['postgres']['password'],
                              host = psql_config['postgres']['HOST'],
                              port = psql_config['postgres']['port'],
                              database= psql_config['postgres']['database'] )

#=================================================
#CREATE A CURSOR TO PERFORM DATABASE OPERATIONS 
#=================================================
cursor = connection.cursor()


#=================================================
# CREATE A QUERY
#=================================================
query1 = "select * from provider "

try:
    cursor.execute(query1)
finally:
    print('execution succesful')

#=================================================
# FETCH ALL RECORDS AND LOOP FOR THE NAME 'John'
#=================================================
records = cursor.fetchall()
for row in records:
    if 'John' in row[1]:
        print(row[0])

#=================================================
# DISPOSE THE CURSOR AND CONNECTION IF NOT NEEDED
#=================================================
cursor.close()
connection.commit()
connection.close()




"""
10. Create a shell script that contains a variable called “pg_con” which will connect to postgresql and 
write a sql statement using the sql from question 3 against the variable that output just the value and nothing else.  

I have used this time ‘SQLALCHEMY’ library of python to connect to the database.
"""



#=================================================
# IMPORT MODULES TO CONNECT TO POSTGRES DATABASE
#=================================================
from allconfigs.configs import psql_config   
from sqlalchemy import create_engine
from sqlalchemy.engine.url import URL



#===============================================================
# CONNECTING TO AN EXISTING POSTGRES DATABASE THROUGH SQLALCHAMY
#===============================================================
engine_source =create_engine(
    str(
        URL.create(
            drivername=psql_config['postgres']['drivername'],
            host=psql_config['postgres']['host'],
            password=psql_config['postgres']['password'],
            port=psql_config['postgres']['port'],
            username=psql_config['postgres']['user'],
            database=psql_config['postgres']['database']
        )
  )
)

pg_con = engine_source.connect()





#=================================================
#  TESTING CONNECTION
#=================================================
try:
    pg_con.execute("SELECT 'connection successfull' AS status " )
except ConnectionError as ce:
    print('ConnectionError occured')
    

#=========================================================
# DOCSTRING ABOUT A TRICK USAGE OF   '%'  IN SQLALCHEMY 
#==========================================================
""" If you're using SQLAlchemy: Use "%%" instead of "%" in your queries, because 
a single "%" is used in Python string formatting.
"""

#========================================================
# CREATE QUERY TO GET THE ANSWER OF NUMBER  3 QUESTION
#========================================================
query1 = """
with source_combined as(
    select *
    from provider_practice
    join provider_profession
    on provider_practice.provider_id = provider_profession.provider_id 
    join profession
    on profession.profession_id = provider_profession.profession_id
)
,calculate_provider_degree_city as (
    select count(*)
    from source_combined
    where profession_degree = 'DO'
    and city ilike '%%er%%'
)

, final as(
    select * from calculate_provider_degree_city
)
select * from final """

#=================================================
# PRINT THE OUTPUT THROUGH EXECUTION
#=================================================
rows=pg_con.execute(query1)
for row in rows:
    print(row[0])


#=================================================
# CLOSE THE CONNECTION IF NOT NEEDED
#=================================================
pg_con.close()

