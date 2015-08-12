Example for Genero 3.0 EAP using the new base.SQlHandle methods

Reimplemented Quanta's qselect funciton using the base.SqlHandle methods

qselect is quick utility funciton that is effectively

CALL qselect(COLUMNLIST, TABLENAME, PRIMARY KEY LOOKUP) RETURNIJNG ok, value1, ...

Behind the scenese it reuses a cursor if that same lookup has been made
previously, and keeps a cache of X cursors.

For a developer, a quick lookup is one line of code without having to 
explicitly code cursors etc.
