# Lab01 - First Cut at Track Message

First, make sure daffodil works:

    daffodil --version

This should display a version number such as 3.5.0 or higher. 

Take a quick look at a track message.

    xxd test_track_good_01.dat # get a hex dump of a track message

Parse it to XML using the schema via the daffodil command line interface (CLI):
 
    daffodil parse -s fakeTDL.dfdl.xsd test_track_good_01.dat

This outputs just one field at the start of the track message. 

Now follow the exercise instructions in the fakeTDL.dfdl.xsd file to fill 
in the rest of the track message field definitions. You can do them one by one
and test each new element as you add it. You will no-doubt encounter some 
_Schema Definition Errors_ from Daffodil as you go. 

Repeat the parse command above until you think you are getting the expected XML out. 

You can also do some negative testing. Try:

    daffodil parse -s fakeTDL.dfdl.xsd test_track_bad_01.dat

That will give you a _Parse Error_. That file doesn't have enough data for a whole message.

Now try an _unparse_, from some bad XML.

    daffodil unparse -s fakeTDL.dfdl.xsd test_track_bad_02.xml

That will give you an _Unparse Error_. Take a look at test_track_bad_02.xml to see that
there is much wrong with it. 

Parse Error and Unparse Error are collectively called _Processing Errors_. They indicate 
something wrong with the data (or infoset XML in case of unparse), which does not match the 
DFDL schema.

Contrast that with Schema Definition Error (SDE) which means that the DFDL schema isn't meaningful, 
so no point in even trying to use it to parse or unparse. 

## Trace and Debug

The daffodil CLI supports a very verbose trace mode, and a breakpoint/single-step interactive 
debugger.

Try this command to examine the trace output. 

Using daffodil 3.10.0 or later

    daffodil parse -t -s fakeTDL.dfdl.xsd test_track_good_01.dat

Using daffodil 3.9.0 or earlier

    daffodil -t parse -s fakeTDL.dfdl.xsd test_track_good_01.dat

This will output a large amount of data showing each parse operation along with a data dump
and the infoset as it is incrementally created. Capturing the output into a file so you 
can scroll around it in a text editor is recommended.

To try the interactive debugger issue this command:

Using daffodil 3.10.0 or later:

    daffodil parse -d -s fakeTDL.dfdl.xsd test_track_good_01.dat

Using daffodil 3.9.0 or earlier:

    daffodil -d parse -s fakeTDL.dfdl.xsd test_track_good_01.dat


This will then display an interactive prompt `(debug)`.
At that prompt, type these commands to instruct the debugger to display some information 
every time it stops:

    display info data
    display info parser
    display info infoset

Now you can single step through the parsing of the data. 
The single-step command is "step" or just "s".

Help for the interactive debugger commands is available by the command "help". 
