# STORING & SELCTING DATA SECTION 
# by : Bakti Siregar, M.Si
# Department of Business statistics, Matana University (Tangerang)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# 1. Connect, Create, and Drop database using RMariaDB 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# install.packages("RMariaDB")                        # install packages
# install.packages("openxlsx")                        # install packages
library(RMariaDB)                                     # use library
library(RMySQL)                                       # use library
library(sqldf)                                        # use library
library(openxlsx)                                     # use library

mydb<-dbConnect(MariaDB(),
                user='root',
                password='', 
                host='localhost')
dbExecute(mydb,"CREATE DATABASE week6")               # Create Database
# dbExecute(mydb,"DROP DATABASE week6")                  # Drop table


# 2. Connect, Create, and Drop table using RMariaDB 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mydb <- dbConnect(MySQL(),
                  user='root', 
                  password='', 
                  dbname='week6',                           
                  host='localhost')
dbListTables(mydb)                                    # looking for table list on your data base
data <-read.xlsx("McDodol.xlsx",sheet=1)              # read "Data Marketing McDodol" from exel file
dbWriteTable(mydb, "marketing", data)                 # write/store table "marketing" to database 
marketing <-dbGetQuery(mydb,"select* from marketing") # read data from database (sql)
View(marketing)                                       # view table
# dbExecute(mydb,"DROP TABLE marketing")              # Drop table Marketing from Database


# 3a. Select dataset/table that you need to observes as branch manager (Jawa Timur)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
jawa_timur<-dbGetQuery(mydb,"
                       SELECT * 
                       FROM marketing 
                       WHERE area = 'jawatimur'")  

# 3.b Get a count of total sales at your branch week by week (Jawa Timur)!
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
weekly_sales <- dbGetQuery(mydb,"
                           SELECT week, 
                           SUM(sales_in_thousands) 
                           FROM marketing  
                           WHERE area='jawatimur' 
                           GROUP BY week")

# 3.c Please show me the sales performance of your branch for each location!
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
location_sales <- dbGetQuery(mydb,"
                             SELECT location_id, 
                             SUM(sales_in_thousands) 
                             FROM marketing 
                             GROUP BY location_id")

# 3.d Sort the data to see if there is an impact of the number of promotions being carried out?
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
count_promotions <- dbGetQuery(mydb,"
                               SELECT promotion, 
                               SUM(sales_in_thousands) 
                               FROM marketing 
                               GROUP BY location_id")

# 3.e Sort the data to see if there is an impact of the number of promotions being carried out, 
#     exluding age of store greather than 6 years
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
store_greather_than6 <- dbGetQuery(mydb,"
                                   SELECT promotion, 
                                   SUM(sales_in_thousands), 
                                   age_of_store > 6
                                   FROM marketing 
                                   GROUP BY location_id")


# 4. Selecting Multi-Table
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
table2 <-read.xlsx("McDodol.xlsx",sheet=2)        # read "Data Marketing McDodol" from exel file
dbWriteTable(mydb, "finance", table2)             # write/store table2 "finance" to database 
finance <-dbGetQuery(mydb,"select* from finance") # read table from database 
View(finance)                                     # view table


# 4a. Use (left joint or right join or inner join) to select only records that match both 
#     tables without any duplicate data!
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
left_join <- dbGetQuery(mydb,"
                        SELECT * 
                        FROM marketing a 
                        LEFT JOIN finance b ON a.location_id=b.location_id 
                        WHERE a.area= 'medan'")


# Refrence : 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# https://www.w3schools.com/ 
# https://www.guru99.com/introduction-to-database-sql.html



                   