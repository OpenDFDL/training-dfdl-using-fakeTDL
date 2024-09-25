# Lab03 - Improving the Schema to Check Validity

In this lab we have modified the schema to add XSD range, pattern and enum constraints
(XSD calls them facets) that allow us to detect data that is well-formed, but invalid.

Look back at the FakeTDLSpecification document at the definition of 
the track message. You'll see that many of the fields have numeric range
restrictions. 

Examine how these restrictions are captured in the fakeTDL.dfdl.xsd
schema.

Examine that we're now sharing where track message fields have the
same type and DFDL representation properties, by moving the properties
onto a shared type definition.

## Exercise

Run the tests via:

    daffodil test TestFakeTDL.tdml

You'll see that one test fails. Studying that
test in the TDML, or rerunning just that one
test with the "-i" you will see that the test is failing
due to the data being well-formed, but highly invalid.
Almost every field/element is invalid. 

You can fix the test by removing the bogus error string that
intentionally makes the test fail, and using instead
error strings from the actual error messages, examples of
which are provided there with the test. 
