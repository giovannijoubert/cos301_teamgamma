public class NeuralNetwork
{
	  public static boolean convertDataToTestCSV() {
		  return true;
	  }

	  public static String normalizeTestCSV() {
		return "success";
	  }

	  //with data we get from conversion team in JSON obj, we take 2/3 of the data and put it into TrainingCSV
	  public static boolean convertDataToTrainingCSV() {
		  return true;
	  }

	  public static String normalizeTrainingCSV() {
		  return "success";
	  }

	  public static boolean recordReaderTraining() {
		  return true;
	  }

	  public static boolean recordReaderTest() {
		  return true;
	  }

	  public static boolean dataSetIteratorTraining() {
		  return true;
	  }

	  public static boolean dataSetIteratorTest() {
		  return true;
	  }

	  public static String multilayer() {
		  return "created";
	  }

	  public static String trainingModel() {
		  return "accurate";
	  }

	  public static String evaluateModel() {
		  return "trained";
	  }
}