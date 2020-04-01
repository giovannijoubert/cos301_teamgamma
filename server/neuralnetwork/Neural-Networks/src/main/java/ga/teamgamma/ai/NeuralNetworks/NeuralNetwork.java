package ga.teamgamma.ai.NeuralNetworks;

import org.deeplearning4j.nn.conf.GradientNormalization;
import org.deeplearning4j.nn.conf.MultiLayerConfiguration;
import org.deeplearning4j.nn.conf.NeuralNetConfiguration;
import org.deeplearning4j.nn.conf.distribution.Distribution;
import org.deeplearning4j.nn.conf.distribution.NormalDistribution;
import org.deeplearning4j.nn.conf.inputs.InputType;
import org.deeplearning4j.nn.conf.layers.*;
import org.deeplearning4j.nn.multilayer.MultiLayerNetwork;
import org.deeplearning4j.nn.weights.WeightInit;
import org.deeplearning4j.nn.weights.WeightInitDistribution;
import org.deeplearning4j.util.ModelSerializer;
import org.nd4j.linalg.activations.Activation;
import org.nd4j.linalg.learning.config.AdaDelta;
import org.nd4j.linalg.lossfunctions.LossFunctions;

import java.io.*;
import java.util.*;

public class NeuralNetwork
{
	int channels = 1;
	static long seed = 123;
	static Random rand = new Random(seed);
	int height = 100;
	int width = 100;
	int numLabels = 12;

	public static File exportModel() {
		return new File("../NeuralNetworkConfiguration.zip");
	}

	/**
	 * PARAMETERS:
	 * ==============================
	 * 1.) Bias
	 * 			- Allows you to shift the activation function to the left or right, allowing better fit to data.
	 * 			-Typically important in first layer, but it plays less of a role in fully connected layers towards the end.
	 * 			-For images, it may actually be better not to use a bias at all.
	 * 2.) Padding
	 * 				-
	 * 3.) Stride
	 * 				-
	 * 4.) Number of nodes
	 * 			- Start with a minimum number of hideen nodes, increase the hidden nodes number until you get a good performance.
	 * 			- Too few nodes 	-> high error as the predictive factors might be too complex for a small number of nodes to capture.
	 * 			- Too many nodes 	-> will overfit to your training data and not generalize well.
	 * 			- The number of hidden nodes you should have is based on a complex relationship between
	 * 				1.) Number of input and output nodes
	 * 				2.) Amount of training data available
	 * 				3.) Complexity of the function that is trying to be learning
	 * 				4.) The training algorithm
	 * */
	@SuppressWarnings("SameParameterValue")
	private ConvolutionLayer convInit(String name, int in, int out, int[] kernel, int[] stride, int[] pad, double bias)
	{
		return new ConvolutionLayer
									.Builder(
												kernel,			//kernel size
												stride,			//stride
												pad				//padding		-
											)
									.name(name)					//name of the layer
									.nIn(in)					//number of inputs to the layer (input size)
									.nOut(out)					//number of outputs of the layer(output size)
									.biasInit(bias)				//bias
									.build();
	}

	private ConvolutionLayer conv3x3(String name, int out, double bias)
	{
		return new ConvolutionLayer
									.Builder(
												new int[]{3,3},	//kernel size
												new int[] {1,1},//stride
												new int[] {1,1}	//padding
												)
									.name(name)					//name of the layer
									.nOut(out)					//number of outputs of the layer(output size)
									.biasInit(bias)				//bias
									.build();
	}

	@SuppressWarnings("SameParameterValue")
	private ConvolutionLayer conv5x5(String name, int out, int[] stride, int[] pad, double bias)
	{
		return new ConvolutionLayer
									.Builder(
												new int[]{5,5},	//kernel size
												stride,			//string
												pad				//padding
											)
									.name(name)					//layer name
									.nOut(out)					//number of outputs of the layer(output size)
									.biasInit(bias)				//bias
									.build();
	}

	private SubsamplingLayer maxPool(String name, int[] kernel)
	{
		return new SubsamplingLayer
									.Builder(
												kernel,			//kernel size
												new int[]{2,2}	//filter
												)
									.name(name)					//layer name
									.build();
	}

	@SuppressWarnings("SameParameterValue")
	private DenseLayer fullyConnected(String name, int out, double bias, double dropOut, Distribution dist)
	{
		return new DenseLayer
							.Builder()
							.name(name)
							.nOut(out)
							.biasInit(bias)
							.dropOut(dropOut)
							.weightInit(new WeightInitDistribution(dist))
							.build();
	}

	public MultiLayerNetwork alexnetModel()
	{
		/**
		 * THINGS WE CAN CHANGE:
		 * ---------------------
		 * 1.) The number of layers
		 * 2.) The number of kernels
		 * 3.) Kernel sizes
		 * 4.) Number of neurons in fully connected layers
		 * 5.) Other regularization methods like L1/L2
		 * */
		double bias = 1;
		double dropOut = 0.5;

		MultiLayerConfiguration conf = new NeuralNetConfiguration.Builder()
				.seed(seed) // constant seed
				.weightInit(
						new NormalDistribution(
								0.0,
								0.01
						)
				)
				.activation(
						Activation.RELU									//activation function is RELU
				)
				.updater(new AdaDelta())
				.gradientNormalization(GradientNormalization.RenormalizeL2PerLayer)
				.l2(0.0005) //5 * 1e-4
				.list()
				/**====================================================================/
				/**Convolutional Layer 1*/
				.layer(
						convInit(
								"cnn1",
								1,									//channels - 1 because grey scale.
							96,									//filters - 96 (of size 11x11) WHY!!!!
								new int[]{11, 11},						//kernel - 11x11 window to capture objects
								new int[]{4, 4},						//stride - 4 to reduce size
								new int[]{3, 3},						//padding
							0										//bias - 0 for no bias
						)
				)
				/**Normalization Layer 1*/
				.layer(
						new LocalResponseNormalization
													.Builder()
													.name("lrn1")
													.build()
				)
				/**Max-Pooling Layer 1*/
				.layer(
						maxPool(
								"maxpool1",						//
								new int[]{3,3}							//pooling size - 3x3
								)
				)
				/**====================================================================/
				/**Convolutional Layer 2*/
				.layer(
						conv5x5(
								"cnn2",							//
								256,								//filters - 256 ?
								new int[] {1,1},						//stride -  (1x1)
								new int[] {2,2},						//padding - 2x2 for consistent height/width
								bias									//bias -
						)
				)
				/**Normalization Layer 2*/
				.layer(
						new LocalResponseNormalization
													.Builder()
													.name("lrn2")
													.build()
				)
				/**Max-Pooling Layer 2*/
				.layer(
						maxPool(
								"maxpool2",
								new int[]{3,3}							//pool size - 3x3
								)
				)
				/**====================================================================*/
				/**Convolutional Layer 3 */
				.layer(
						conv3x3(
								"cnn3",
								384,							//output size/number of outputs of the layers -
								0								//bias - 0 for no bias
						)
				)
				/**====================================================================*/
				/**Convolutional Layer 4 */
				.layer(
						conv3x3(
								"cnn4",
								384,							//output size/number of outputs of the layers -
								bias								//bias - 1
						)
				)
				/**====================================================================*/
				/**Convolutional Layer 5 */
				.layer(
						conv3x3(
								"cnn5",
								256,							//output size/number of outputs of the layers -
								bias								//bias - 1
						)
				)
				//Reduce dimentionality
				.layer(
						maxPool(
								"maxpool3",
								new int[]{3,3}						//pool size - 3x3
								)
				)
				/**====================================================================*/
				/**Convolutional Layer 6 */
				.layer(
						fullyConnected(
								"ffn1",
								4096,							//output size/number of outputs of the layers
								bias,								//bias - 1
								dropOut,							//drop out - 0.5, anything <= 0.5 gets dropped out
								new NormalDistribution(
										0,
										0.005
								)
						)
				)
				/**====================================================================*/
				/**Convolutional Layer 7 */
				.layer(
						fullyConnected(
								"ffn2",
								4096,							//output size/number of outputs of the layers
								bias,								//bias - 1
								dropOut,							//drop out -
								new NormalDistribution(
										0,
										0.005
								)
						)
				)
				/**====================================================================*/
				/**Output Layer*/
				//Output layer
				.layer(
						new OutputLayer
										.Builder(LossFunctions.LossFunction.NEGATIVELOGLIKELIHOOD)
										.name("output")
										.nOut(numLabels)			 //12 Mouth Shapes
										.activation(
												Activation.SOFTMAX	//activation function - softmax
										)
										.build())
				/**====================================================================*/
				.setInputType(
								InputType.convolutional(
										height,						//height   - 100
										width,						//width    - 100
										channels					//channels - 12
								)
				)
				.build();
				/**====================================================================*/
		return new MultiLayerNetwork(conf);
	}

	public MultiLayerNetwork lenetModel() {
		/*
		 * Revisde Lenet Model approach developed by ramgo2 achieves slightly above random
		 * Reference: https://gist.github.com/ramgo2/833f12e92359a2da9e5c2fb6333351c5
		 */
		MultiLayerConfiguration conf = new NeuralNetConfiguration.Builder()
				.seed(seed)
				.l2(0.005)
				.activation(Activation.RELU)
				.weightInit(WeightInit.XAVIER)
				.updater(new AdaDelta())
				.list()
				.layer(0, convInit("cnn1", channels, 50 ,  new int[]{5, 5}, new int[]{1, 1}, new int[]{0, 0}, 0))
				.layer(1, maxPool("maxpool1", new int[]{2,2}))
				.layer(2, conv5x5("cnn2", 100, new int[]{5, 5}, new int[]{1, 1}, 0))
				.layer(3, maxPool("maxool2", new int[]{2,2}))
				.layer(4, new DenseLayer.Builder().nOut(500).build())
				.layer(5, new OutputLayer.Builder(LossFunctions.LossFunction.NEGATIVELOGLIKELIHOOD)
						.nOut(10)
						.activation(Activation.SOFTMAX)
						.build())
				.setInputType(InputType.convolutionalFlat(28, 28, 1))
				.build();

		return new MultiLayerNetwork(conf);

	}
}