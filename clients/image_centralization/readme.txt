Example for Genero 3.0 EAP using new image centralization feature

This example shows all the fontawesome files in the current fontfile.

In FGLDIR/lib you will find a file image2font.txt that references the fontfile 
font file FontAwesome.ttf in the same directory.

These images are on the server and are hence available for ALL clients
as opposed to GDC, GWC, GeneroMobile having their own set of iamges each.

To see how to do colour, add the following lines to the end of the 
image2font.txt file ...

circle-red=FontAwesome.ttf:f111:red
circle-orange=FontAwesome.ttf:f111:orange
circle-green=FontAwesome.ttf:f111:#00FF00

... essentially the last entry on the line indicates what colour to use when
rendering the image.