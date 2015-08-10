Example for Genero 3.0 EAP using the new ON TIMER syntax

The ON TIMER X clause will be executed every X seconds.
Different from ON IDLE in that the user can be doing something.

Useful for screens like this where it is a list that is automatically refreshed
every X seconds.  

We would expect typical usage to be ON TIMER 60 rather than ON TIMER 1 as in 
this example, the use of 1 is just for example purposes to force more regular
updates.

You should check that the behaviour is as you anticipate when you move out of
the dialog. ie note what happens if you click assign and sit in the PROMPT
for a length of time.