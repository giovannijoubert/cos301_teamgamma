import java.io.*;
import java.util.*;

public class NeuralNetwork
{
	int channels = 2;
	static long seed = 123;
	static Random rand = new Random(seed);
	int height = 100;
	int width = 100;
	int numLabels 12;

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

	public static void exportModel() {
	  return "model exported";
	}

	@SuppressWarnings("SameParameterValue")
	private ConvolutionLayer convInit(String name, int in, int out, int[] kernel, int[] stride, int[] pad, double bias) {
		return new ConvolutionLayer.Builder(kernel, stride, pad).name(name).nIn(in).nOut(out).biasInit(bias).build();
	}

	private ConvolutionLayer conv3x3(String name, int out, double bias) {
		return new ConvolutionLayer.Builder(new int[]{3,3}, new int[] {1,1}, new int[] {1,1}).name(name).nOut(out).biasInit(bias).build();
	}

	private SubsamplingLayer maxPool(String name,  int[] kernel) {
		return new SubsamplingLayer.Builder(kernel, new int[]{2,2}).name(name).build();
	}

	@SuppressWarnings("SameParameterValue")
	private DenseLayer fullyConnected(String name, int out, double bias, double dropOut, Distribution dist) {
		return new DenseLayer.Builder().name(name).nOut(out).biasInit(bias).dropOut(dropOut).weightInit(new WeightInitDistribution(dist)).build();
	}

	private MultiLayerNetwork alexnetModel()
	{
		double bias = 1;
		double dropOut = 0.5;

		MultiLayerConfiguration conf = new NeuralNetConfiguration.Builder()
				.seed(seed) // constant seed
				.weightInit(new NormalDistribution(0.0, 0.01)) //add weights to all the nodes
				.activation(Activation.RELU)
				.updater(new AdaDelta())
				.gradientNormalization(GradientNormalization.RenormalizeL2PerLayer)
				.l2(5 * 1e-4) // 0.0005
				.list()
				.layer(convInit("cnn1", channels, 96, new int[]{11, 11}, new int[]{4, 4}, new int[]{3, 3}, 0))
				.layer(new LocalResponseNormalization.Builder().name("lrn1").build())
				.layer(maxPool("maxpool1", new int[]{3,3}))
				//Make the convolutional window smaller and set padding to 2 for consistent height/width
				.layer(conv5x5("cnn2", 256, new int[] {1,1}, new int[] {2,2}, bias))
				.layer(new LocalResponseNormalization.Builder().name("lrn2").build())
				.layer(maxPool("maxpool2", new int[]{3,3}))
				//Use three successive convolutional layers and a smaller convolution window
				.layer(conv3x3("cnn3", 384, 0))
				.layer(conv3x3("cnn4", 384, bias))
				.layer(conv3x3("cnn5", 256, bias))
				//Reduce dimentionality
				.layer(maxPool("maxpool3", new int[]{3,3}))
				//Expensice dense layer
				.layer(fullyConnected("ffn1", 4096, bias, dropOut, new NormalDistribution(0, 0.005)))
				.layer(fullyConnected("ffn2", 4096, bias, dropOut, new NormalDistribution(0, 0.005)))
				//Output layer
				.layer(new OutputLayer.Builder(LossFunctions.LossFunction.NEGATIVELOGLIKELIHOOD)
						.name("output")
						.nOut(numLabels)
						.activation(Activation.SOFTMAX)
						.build())
				.setInputType(InputType.convolutional(height, width, channels))
				.build();

		return new MultiLayerNetwork(conf);
	}
}