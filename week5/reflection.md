\# Lab 5 Reflection


Running SELECT queries should be safe since they only read the data from the database. The statements such as UPDATE or DELETE fall under DML (Data Manipulation Language), meaning that they perform some changes to the database, for example, deleting or updating records. The commands DROP or ALTER belong to DDL (Data Definition Language) which may alter the structure of the database. Therefore, using SELECT will either show some results or will produce an error message in case of an incorrect query, making it a safe operation for testing purposes.

 

In Task 4, I have taken out the quotation marks around the Cat in my query. Upon running the query, MySQL produced an error 1054 with message that Cat is an unknown column. I figured out the issue by looking at the console error message. It demonstrated that the MySQL engine thought that Cat was an actual column name because I have taken off the quotation marks which were initially indicating that it is a text string. By adding back the single quotation marks, the query worked properly and returned all the cat rows.

