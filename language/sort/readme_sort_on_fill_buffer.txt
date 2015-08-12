Example for Genero 3.0 EAP using the new sort method in a paged array

So note the use of the ON SORT block which is triggered when user
taps in column headers,
Note use of DIALOG.getSortKey() and DIALOG.isSortReverse()
These are used to sort the array, or if you were using a database table
recast the SQL statement with a different ORDER BY clause.