Example for Genero 3.0 EAP using the new IMAGE ACTION attribute

Example showing how ACTION can be added to row images to be be used to indicate
a different action.

NOTE: Before running, add the following line to FGLDIR/lib/image2font.txt

fa-shopping-cart-grey=FontAwesome.ttf:f07a:grayText

This is a copy of the following line ... 

fa-shopping-cart=FontAwesome.ttf:f07a

... with the colour "grayText" which is a system colour used for inactive
widgets.

Note how the code passes through a single ON ACTION clause so you have to 
keep track of what image was displayed so that you can do an IF based on it. 

