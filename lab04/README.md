# Lab04a - Multiple Message Types


## Adding the Identity and Ack Message Types

This lab adds the other two fakeTDL message types as choices.
The property `dfdl:initiatedContent` is used to tell the DFDL 
processor that all the initiators are unique and once found they will
discriminate the choice of the branch. 

Two simple positive self-contained `parserTestCase` elements are added 
to the `TestFakeTDL.tdml` test suite to exercise these new message types. 

## Rich Pattern Facets

The pattern facet used for `identDescription` field in the identity message type
has a very complex regular expression. Review the notes there about 
things we avoid using in patterns to avoid data security issues where 
regular expressions can match giant/excessive amounts of data. 

## Arrays with Stored Count

The ack message type contains an array of 1 or more ackID numbers.
There is a count field which stores how many are actually present. 
Review the `simpleType` of the count field for the 1 to 12 range restriction,
and review how the array of messageID items uses an occurs count expression to
read the count field. The count field's value is determined automatically 
when unparsing by way of the dfdl:outputValueCalc property so that the count 
field is populated automatically and *must* match the data being unparsed. 
