import org.apache.daffodil.tdml.Runner

import org.junit.AfterClass
import org.junit.Test

object TestFakeTDL {
  lazy val runner = Runner("", "TestFakeTDL.tdml")

  @AfterClass def shutDown(): Unit = {
    runner.reset
  }
}

/**
 * This just makes it convenient to run all the tests via 'sbt test'
 * which is a convention that some regression test rigs depend on.
 *
 * One can also run tests from the Daffodil Command Line Interface (CLI)
 */
class TestFakeTDL {

  import TestFakeTDL._

  @Test def test_all_tdml(): Unit = { runner.runAllTests() }

  // A JUnit run of just a single test can be done like this,
  // and some IDEs like IntelliJ IDEA will let you click on this to run
  // it conveniently.
  // @Test def test_track_good_01(): Unit = { runner.runOneTest("test_track_good_01") }

}
