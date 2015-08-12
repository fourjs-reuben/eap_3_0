Example for Genero 3.0 EAP using the new programmable webcomponent feature

Key thing to note is how the 4gl calls a javascript function in the webcomponet

CALL ui.interface.frontcall("webcomponent","call",args...

and in the .html there is a function that is called. In this case setById
which simply replaces part of the HTML with what is passed in