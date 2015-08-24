Example for Genero 3.0 EAP using the existing HTTP classes to server web pages

Note: Program has set FGLAPPSERVER to 8093

Run the program, and in a browser, enter the following URL's

http://localhost:8093/test?<Arguments> - Will display a page containing the arguments
http://localhost:8093/list - Clicking a value will link to http://localhost:8093/record?<Argument>
http://localhost:8093/storage - shows the HTML5 storage options
http://localhost:8093/form_encoded - Will results in a POST to http://localhost:8093/form_encoded_result

The key thing to take out of this page is that you can use 4gl and your 
existing 4gl functions in the generation of Web Pages.

In these examples I have been creating an xml Document and returning it as 
text aka an HTML page, but you can use other techniques such as xslt
transforamtion to generate your html from data.

