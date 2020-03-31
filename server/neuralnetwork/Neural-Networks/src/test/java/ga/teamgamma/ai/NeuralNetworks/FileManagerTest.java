package ga.teamgamma.ai.NeuralNetworks;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author aaron
 */
public class FileManagerTest {
    
    public FileManagerTest() {
    }
    
    @BeforeAll
    public static void setUpClass() {
    }
    
    @AfterAll
    public static void tearDownClass() {
    }
    
    @BeforeEach
    public void setUp() {
    }
    
    @AfterEach
    public void tearDown() {
    }

    /**
     * Test of addFile method, of class FileManager.
     */
    @Test
    public void testAddFile() throws Exception {
        System.out.println("Running addFile Test:");
        MultipartFile inputFile = null;
        String sound = "test";
        FileManager instance = new FileManager();
        instance.addFile(inputFile, sound);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }
    
}
