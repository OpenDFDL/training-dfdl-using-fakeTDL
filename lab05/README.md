# Lab05 - Organization for Production and Maintenance 

With the functionality of the schema complete, now we put in place
a few organizational changes that make using the schema in a 
cybersecurity system, and maintaining it over time, easier.

## Change Summary

- Setting up for using the 'sbt' tool and daffodil-sbt plugin to compile the schema to binary form.
  - This adds the project directory used by 'sbt' where the daffodil-sbt plugin
    is specified with its version, and also adds the build.sbt file which specifies
    the versions (of Daffodil) for which the schema will be compiled.
  - This requires dividing the schema and the test artifacts into src and test 
    directories.
- Splitting the single large schema file into multiple files in a sensible manner
  - `fakeTDL-base.dfdl.xsd` - base format reused by other files
  - `fakeTDL.dfdl.xsd` - global element declarations for fakeTDL and fakeTDLFile
    - This schema file has no target namespace so our XML no longer has
    any namespace prefixes. 
  - `fakeTDLType.dfdl.xsd` - primary type (fakeTDLType), and message definitions
  - `fakeTDL-field-types.dfdl.xsd` - types of the message fields
  - `fakeTDL-enum-entityTypeDetails.dfdl.xsd` - enum type definition
- Add `.gitattributes` file to specify the ".dat" files are binary, not text. 

## Compiling the Schema to Daffodil ".bin" Binary Form
This will construct all the compiled daffodil ".bin" binaries, placing them
into the target directory. 

The specific versions of Daffodil it will use
are specified in the build.sbt file. 

    sbt packageDaffodilBin

will construct all the corresponding ".bin" binary files giving them names
which clarify the Daffodil version they are compiled for. 

## Regression Testing

This will run all the TDML tests:

    daffodil test -i test/TestFakeTDL.tdml

## Testing Multiple Messages at Once

The file `test_file_01.dat` contains multiple messages. All of them can be fed to 
a DFDL parse using the daffodil CLI `--stream` option:

    daffodil parse --stream -s ../src/fakeTDL.dfdl.xsd test_file_01.dat

## Filtering Messages using XSLT 

The `block_fakeTDL_ag123.xsl` is an XSLT transformation that converts 
the XML of a fakeTDL message into nothing at all if the `source` field of 
the message contains `AG123`. This is an example of a simple message filtering
rule based on the source unit number. 

The script `xslt-stream.sh` takes an XSLT file as argument, and expects a stream
of XML documents on its input (NUL separated, which is the
way they are separated coming out of `daffodil parse --stream ...` ). 
It transforms each XML document using the stylesheet passed as the argument. 

Try:

    daffodil parse --stream      \
      -s ../src/fakeTDL.dfdl.xsd \
      test_file_01.dat 

The output from the above will be identical to the `test_file_01.xml` which is not a standard
XML file, but a stream of XML documents terminated separated by NUL characters. 

Now add the XSLT transform:

    daffodil parse --stream      \
      -s ../src/fakeTDL.dfdl.xsd \
      test_file_01.dat |         \
      ./xslt-stream.sh block_fakeTDL_ag123.xsl

If you look at `test_file_01.xml`, you'll see that there are 3 messages, the first two 
have `AG123` as the `source`. Hence, the above command line filters them out, leaving only
the third ack message.

The following will further unparse the surviving message(s) back to native form.

    daffodil parse --stream \
        -s ../src/fakeTDL.dfdl.xsd test_file_01.dat |  \
      ./xslt-stream.sh block_fakeTDL_ag123.xsl | \
      daffodil unparse --stream -s ../src/fakeTDL.dfdl.xsd

This will output the native form of just a single ack message, as the XSLT filtered out 
the first two messages. The result will be identical to the last 64 bytes of the
`test_file_01.dat` data. 
