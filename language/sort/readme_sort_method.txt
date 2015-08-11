Example for Genero 3.0 EAP using the new sort method

The thing to note with the new sort method is how oyu handle ties.  The 
technique is to sort on the least significant factor first then the next most
significant column and so on.

So in this Olympic medal, we want to rank on gold then silver then bronze and
then alphabetical order, so that means the order of the sort calls is
            CALL arr.sort("country", FALSE)
            CALL arr.sort("bronze", TRUE)
            CALL arr.sort("silver", TRUE)
            CALL arr.sort("gold", TRUE)
ie least significant first.

