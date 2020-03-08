# STORING & SELCTING DATA 
# by : Bakti Siregar, M.Si
# Department of Business statistics, Matana University (Tangerang)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# 1. Storing data using RMySQL 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# install.packages("RMySQL")                        # install packages
library(RMySQL)                                     # use library
mydb <- dbConnect(MySQL(),
                  user='root', 
                  password='', 
                  host='localhost')
dbExecute(mydb,"CREATE DATABASE week6")             # Create Database
# dbExecute(mydb,"DROP DATABASE week6")             # Drop table

# 2. Connect, Create, and Drop table using RMySQL 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mydb <- dbConnect(MySQL(),
                  user='root', 
                  password='', 
                  dbname='week6',                           
                  host='localhost')
dbListTables(mydb)                                  # looking for table list on your data base
table1<-read.csv("employees.csv")                   # read employees.csv file from your computer
table2<-read.csv("orders.csv")                      # read orders.cs file from your computer
dbWriteTable(mydb, "employees", table1)             # write/store table1 "employees" to database 
dbWriteTable(mydb, "orders", table2)                # write/store table2 "orders" to database

# 2. Simple Query (Selecting Multi-Table)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

# 2.a  Left join employees and orders table (keep all records from employees table, 
#      matching records from orders)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
left_join <- dbGetQuery(mydb,"
                        SELECT * 
                        FROM employees a 
                        LEFT JOIN orders b ON a.id=b.id
                        WHERE a.firstname != 'rudi'")

# 2.b  "Right join" isn't supported in sqldf package, but switching order of tables and 
#       left join is functionally equivalent
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
right_join1 <- dbGetQuery(mydb,"
                          SELECT * 
                          FROM orders b 
                          LEFT JOIN employees a ON a.id=b.id
                          WHERE a.firstname != 'rudi'")

right_join2 <- dbGetQuery(mydb,"
                          SELECT * 
                          FROM employees a 
                          RIGHT JOIN orders b ON a.id=b.id
                          WHERE a.firstname != 'rudi'")

# 2.c  Inner join...select only records that match both tables
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
inner_join <- dbGetQuery(mydb,"
                         SELECT * 
                         FROM employees a, orders b
                         WHERE a.id=b.id")


# 2.d  Realizing some things are priced by piece, figure out who spent less than $20 on
#      any one type of food
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
inexpensive_line_items <- dbGetQuery(mydb,"
                                     SELECT *, 
                                     (item_cost * quantity_ordered) as item_level_cost
                                     FROM orders a 
                                     LEFT JOIN employees b ON a.id= b.id
                                     WHERE item_cost < 20
                                     ORDER BY item_level_cost")

# 2.e  Realizing that even item level cost is wrong question, let say you wants to know whose total 
#      lunch < $50 Need to use GROUP BY to get totals by person, then use HAVING instead of 
#      WHERE because of the use of the GROUP BY summary function (WHERE is a record level operator)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lunch_under_50 <- dbGetQuery(mydb,"
                             SELECT lastname, firstname,
                             SUM(item_cost * quantity_ordered) as lunch_cost
                             FROM orders a 
                             LEFT JOIN employees b ON a.id= b.id
                             GROUP BY a.id
                             HAVING lunch_cost < 50")

# 2.f  If you wants to keep track of food consumption per person, 
#      particularly who the "lightweights" are in the group.  
#      Who's eating less than average on a cost basis?
#      This requires a subquery to first determine the average cost of this meal, 
#      passing that value to the HAVING clause
#      Subquery: returns a single value for the average lunch cost for employees 
#      (those with valid ID num) "SELECT SUM(item_cost * quantity_ordered)/COUNT(DISTINCT id) 
#      as avg_lunch_cost FROM orders WHERE id != 'NA'")
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lower_than_average_cost <-dbGetQuery(mydb,"
                                     SELECT lastname, firstname,
                                     SUM(item_cost * quantity_ordered) as lunch_cost
                                     FROM orders a 
                                     LEFT JOIN employees b ON a.id= b.id
                                     WHERE a.id != 'NA'
                                     GROUP BY a.id
                                     HAVING lunch_cost > (
                                     SELECT SUM(item_cost * quantity_ordered)/COUNT(DISTINCT id) as avg_lunch_cost
                                     FROM orders 
                                     WHERE id != 'NA') ")


dbDisconnect(mydb)                        # disconnect from your database

# Refrence : 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# https://www.w3schools.com/ 
# https://www.guru99.com/introduction-to-database-sql.html

