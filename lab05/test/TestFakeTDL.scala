import org.apache.daffodil.junit.tdml.TdmlSuite
import org.apache.daffodil.junit.tdml.TdmlTests

import org.junit.Test

object TestFakeTDL extends TdmlSuite {
  val tdmlResource = "/TestFakeTDL.tdml"
}

/**
 * This just makes it convenient to run all the tests via 'sbt test'
 * which is a convention that some regression test rigs depend on.
 *
 * One can also run tests from the Daffodil Command Line Interface (CLI)
 */
class TestFakeTDL extends TdmlTests {
  val tdmlSuite = TestFakeTDL

  // A JUnit run of just a single test can be done like this,
  // and some IDEs like IntelliJ IDEA will let you click on this to run
  // it conveniently. When using 'test', the name of the JUnit test is used
  // as the test in the TDML file
  @Test def test_track_good_01 = test
}
