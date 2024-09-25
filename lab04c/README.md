# Lab04c - Arrays and Discriminators, Whole File Testing

With most data formats, writing tests for every individual message 
becomes too burdensome. 

We quickly get to where we want to test many messages at once, using
whole files full of test messages. 

To enable this, we have added a new element named 'fakeTDLFile' to
the schema. This element is just a container for a variable-length
array of items, each a 'fakeTDL' message.  

Look at the fakeTDL.dfdl.xsd file and find the global element declaration
for 'fakeTDLFile'. 

You can parse a file of messages using:

    daffodil parse -s fakeTDL.dfdl.xsd -r fakeTDLFile test_file_01.dat

Note that we had to specify the root element with the '-r fakeTDLFile' option. 
That's because the root element defaults to the first element declaration in the
file, and our fakeTDLFile element declaration is the second one in the file. .

This same test data is run by the test named test_file_01 in the
TDML file. You can run this test via:

     daffodil test -i TestFakeTDL.tdml test_file_01

If you look at the comments for that test case in the TDML file, you'll see that this
tests both parsing and unparsing of the data to the expected XML. 

## Exercise

Look at the definition of 'fakeTDLFile' in fakeTDL.dfdl.xsd. In it you will see
a exercise about discriminators. 

The TestFakeTDL.tdml file defines a test_file_bad_01 which initially expects 
no discriminator. The test expects a "left over data" error. 

This "left over data" error usually means a discriminator is missing for an array 
with dfdl:occursCountKind="implicit" or dfdl:occursCountKind="parsed". 

If you add the discriminator to the schema and rerun the test

    daffodil test -i TestFakeTDL.tdml test_file_bad_01

You will see that "left over data" is no longer the (useless) diagnostic 
you get. Rather you will get out a diagnostic about the data being too short
for a whole fakeTDL message. 

Modify the test so that it doesn't expect "left over data", but instead expects
the useful diagnostics. 
