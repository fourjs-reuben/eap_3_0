Example for Genero 3.0 EAP using the new responsive layout feature

NOTE: Current GDC on Mac OSX does not support, expect to be fixed in next sprint. GDC-3130

Run the program and resize the window to see the new current width and
height being displayed.

The new predefined action windowresized is called whenever the window is
resized, and in this example calls the frontcall to return the current size
of the window.

Note: You should only call 4gl methods such as show/hide to alter the 
appearance of the current window.   