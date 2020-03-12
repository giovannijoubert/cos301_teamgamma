import static org.junit.Assert.*;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Test;
import org.junit.internal.runners.statements.Fail;

public class testing
{
	String currentTest;
	@Test
	public void testingConvertDataToTestCSV()
	{
		assertEquals(true, NeuralNetwork.convertDataToTestCSV());
		currentTest = "convertDataToTestCSV";
	}
	
	@Test
	public void testingConverterDataToTrainingCSV()
	{
		assertEquals(false, NeuralNetwork.convertDataToTrainingCSV());
		currentTest = "convertDataToTrainingCSV";
	}
	
	@Test
	public void testingNormalizeTestCSV()
	{
		assertEquals("success", NeuralNetwork.normalizeTestCSV());
		currentTest = "normalizeTestCSV";
	}
	
	@Test
	public void testingNormalizeTrainingCSV()
	{
		assertEquals("success", NeuralNetwork.normalizeTrainingCSV());
		currentTest = "normalizeTrainingCSV";
	}
	
	@Test
	public void testingRecordReaderTest()
	{
		assertEquals(true, NeuralNetwork.recordReaderTest());
		currentTest = "recordReaderTest";
	}
	
	@Test
	public void testingRecordReaderTraining()
	{
		assertEquals(true, NeuralNetwork.recordReaderTraining());
		currentTest = "recordReaderTraining";
	}
	
	@Test
	public void testingDataSetIteratorTraining()
	{
		assertEquals(true, NeuralNetwork.dataSetIteratorTraining());
		currentTest = "dataSetIteratorTraining";
	}
	
	@Test
	public void testingDataSetIteratorTest()
	{
		assertEquals(true, NeuralNetwork.dataSetIteratorTest());
		currentTest = "dataSetIteratorTest";
	}
	
	@Test
	public void testingMultilayer()
	{
		assertEquals("created", NeuralNetwork.multilayer());
		currentTest = "multilayer";
	}
	
	@Test
	public void testingTrainingModel()
	{
		assertEquals("accurate", NeuralNetwork.trainingModel());
		currentTest = "trainingModel";
	}
	
	@Test
	public void testingEvaluateModel()
	{
		assertEquals("trained", NeuralNetwork.evaluateModel());
		currentTest = "evaluateModel";
	}
	
	//Will be displayed after every test. Comment out '@After' to disable and vice-versa.
	@After
	public void success()
	{
		if(currentTest != null)
			System.out.println("Test:'" + currentTest + "' completed");
	}
}