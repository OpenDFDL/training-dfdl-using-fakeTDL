# Lab02 - Adding Test/QA 

This lab introduces a Built-in-Self-Test (BIST) capability
to the schema

We build-in testing by adding a Test Data Markup Language (TDML) file, 
'TestFakeTDL.tdml', to the schema project.
This contains a test suite which we can grow from a small
initial set of tests to a comprehensive suite of many tests.
Large DFDL schema projects will often have many TDML files, not just one.
But for this small schema just one will suffice.

Take a look at TestFakeTDL.tdml. 

Observe that it has a mixture of positive and negative test cases, and 
that there are parserTestCase - which start from data and create XML, and
unparserTestCases which start from XML and create data. 

Run all the tests in it via:

   daffodil test -i TestFakeTDL.tdml

The "-i" just tells it to be verbose with the output.
If a test fails the "-i" will create output so you can understand the failure.
(Use "-ii" or "-iii" to get increasingly more verbose output.)

You can run exactly one test via its name:

    daffodil test -i TestFakeTDL.tdml test_track_good_01
