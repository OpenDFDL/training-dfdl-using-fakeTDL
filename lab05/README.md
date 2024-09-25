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
  - fakeTDL-base.dfdl.xsd - base format reused by other files
  - fakeTDL.dfdl.xsd - global element declarations for fakeTDL and fakeTDLFile
    - This schema file has no target namespace so our XML no longer has
    any namespace prefixes. 
  - fakeTDLType.dfdl.xsd - primary type (fakeTDLType), and message definitions
  - fakeTDL-field-types.dfdl.xsd - types of the message fields
  - fakeTDL-enum-entityTypeDetails.dfdl.xsd - enum type definition

- Add .gitattributes file to specify the ".dat" files are binary, not text. 

## Compiling the Schema to Daffodil ".bin" Binary Form
This will construct all the compiled daffodil ".bin" binaries, placing them
into the target directory. 

The specific versions of Daffodil it will use
are specified in the build.sbt file. 

    sbt daffodilPackageBin

## Regression Testing

This will run all the TDML tests:

    DAFFODIL_CLASSPATH=src:test
    daffodil test -i test/TestFakeTDL.tdml
