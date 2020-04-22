/**
 *  @file Training.java
 *  @class Training
 *  @author Dylan Krajnc, Pavlo Andrianatos, Rudo Janse van Rensburg, Brad Zietsman
 */
package ga.teamgamma.ai.NeuralNetworks;
import org.datavec.api.io.filters.BalancedPathFilter;
import org.datavec.api.io.labels.ParentPathLabelGenerator;
import org.datavec.api.split.FileSplit;
import org.datavec.api.split.InputSplit;
import org.datavec.image.loader.NativeImageLoader;
import org.datavec.image.recordreader.ImageRecordReader;
import org.datavec.image.transform.FlipImageTransform;
import org.datavec.image.transform.ImageTransform;
import org.datavec.image.transform.PipelineImageTransform;
import org.datavec.image.transform.WarpImageTransform;
import org.deeplearning4j.api.storage.StatsStorage;
import org.deeplearning4j.datasets.datavec.RecordReaderDataSetIterator;
import org.deeplearning4j.datasets.iterator.impl.MnistDataSetIterator;
import org.deeplearning4j.nn.conf.MultiLayerConfiguration;
import org.deeplearning4j.nn.multilayer.MultiLayerNetwork;
import org.deeplearning4j.optimize.api.InvocationType;
import org.deeplearning4j.optimize.listeners.CollectScoresIterationListener;
import org.deeplearning4j.optimize.listeners.EvaluativeListener;
import org.deeplearning4j.optimize.listeners.ScoreIterationListener;
import org.deeplearning4j.ui.api.UIServer;
import org.deeplearning4j.ui.stats.StatsListener;
import org.deeplearning4j.ui.storage.InMemoryStatsStorage;
import org.deeplearning4j.util.ModelSerializer;
import org.nd4j.evaluation.classification.Evaluation;
import org.nd4j.linalg.api.ndarray.INDArray;
import org.nd4j.linalg.dataset.DataSet;
import org.nd4j.linalg.dataset.api.iterator.DataSetIterator;
import org.nd4j.linalg.dataset.api.preprocessor.DataNormalization;
import org.nd4j.linalg.dataset.api.preprocessor.ImagePreProcessingScaler;
import org.nd4j.linalg.primitives.Pair;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.Random;

public class Training
{
    
    private MultiLayerNetwork model = null;

    /**
     * Deeplearning4j-UI
     */

    private UIServer uiServer;
    private StatsStorage statsStorage;

    /**
     *
     * */
    private boolean PRETRAINING = true;

    /**
     * TRAINING
     * */
    private int numRows     = 100,
                numCols     = 100,
                outputNum   = 12,
                numSamples  = 36,//3 samples per formant, 12 formants
                batchSize   = 100;

    /**
     * PRE-TRAINING
     */

    private int NUM_ROWS    = 100,
                NUM_COLUMNS = 100,
                OUTPUT_NUMS = 12,//number of output classes
                BATCH_SIZE  = 10,//batch size for each epoch
                RNG_SEED    = 123,
                NUM_EPOCHS  = 10;//number of epochs to perform

    private  double RATE = 0.0015;//learning rate

    //DataSetIterator trainingIter;
    DataSetIterator testIter;

    private Random rng = new Random(RNG_SEED);

    public Training()
    {
        /**Initialize the user interface backend*/
        uiServer = UIServer.getInstance();

        /**Configure where the network information (gradients, score vs. time etc) is to be stored. Here: store in memory*/
        statsStorage = new InMemoryStatsStorage(); //Alternative: new FileStatsStorage(File), for saving and loading later.
    }

    private void purgeDirectory(File dir){
        for (File file: dir.listFiles()){
            if(file.isDirectory()) purgeDirectory(file);
            else file.delete();
        }
    }

    /**
     * @param pretrain  - boolean, to determine whether there is training or pretraining.
     * @param model     - the model to train or pretrain.
     * @return a trained or pretrained neural network model(A MultilayerNetwork java object)
     */
    public MultiLayerNetwork train(boolean pretrain, MultiLayerNetwork model)
    {
        if((!pretrain && new File("//data//training//00//").listFiles().length >= 10) || (pretrain /*&& new File("//data//pretraining//00//").listFiles().length >= 10)*/)){
            System.out.println("Enough data...");
            try
            {
                return train(model, getTrainingDataSetIterator(pretrain), pretrain);
            }
            catch(Exception e)
            {
                System.err.println("Error Training: "+e.getMessage());
            }
        }else{
            System.out.println("Not enough training data...");
        }
        return null;
    }
    /**
     * @return a List of image tranformation operations.
     */
    private List<ImageTransform> getTransforms()
    {
        return Arrays.asList(new ImageTransform[]
                            {
                                new FlipImageTransform(rng),
                                new WarpImageTransform(rng,42),
                                new FlipImageTransform(new Random(123))
                            });
    }

    /**
     * @param pretrain - boolean, to determine whether the pretraining or training dataset is to be used.
     * @return a DatasetIterator that contains the training or pretraining data.
     */
    private DataSetIterator getTrainingDataSetIterator(boolean pretrain) throws IOException
    {

        if(true) return new MnistDataSetIterator(10, 50, true, true, true, RNG_SEED);

        File parentPath = new File("//data"
                                 /*
                                 System.getProperty("user.dir"),
                                "//src//main//java//ga//teamgamma//ai"
                                */
                                 + (pretrain ? "//pretraining//" : "//training//")
        );

        ParentPathLabelGenerator labelMaker = new ParentPathLabelGenerator();
        //FileSplit trainData = new FileSplit(parentPath, NativeImageLoader.ALLOWED_FORMATS, rng);
        FileSplit fileSplit = new FileSplit(parentPath, NativeImageLoader.ALLOWED_FORMATS, rng);

        int numExamples = ((int) fileSplit.length());
        int nlbls = Objects.requireNonNull(fileSplit.getRootDir().listFiles(File::isDirectory)).length; //This only works if your root is clean: only label subdirs.
        int maxPathsPerLabel = 10; // Not sure if maxPathsPerLabel is right

        BalancedPathFilter pathFilter = new BalancedPathFilter(rng, labelMaker, numExamples, nlbls, maxPathsPerLabel);

        double splitTrainTest = 0.8;
        InputSplit[] inputSplit = fileSplit.sample(pathFilter, splitTrainTest, 1 - splitTrainTest);
        InputSplit trainData = inputSplit[0];
        InputSplit testData = inputSplit[1];

        /*ImageRecordReader recordReader = new ImageRecordReader(numRows,numCols,3,labelMaker);*/

        //recordReader.initialize(trainData);
        /*for (ImageTransform transform : getTransforms()){
            recordReader.initialize(trainData,transform);
        }*/

        ImageTransform flipTransform1 = new FlipImageTransform(rng);
        ImageTransform flipTransform2 = new FlipImageTransform(new Random(123));
        ImageTransform warpTransform = new WarpImageTransform(rng, 42);
        boolean shuffle = false;
        List<Pair<ImageTransform,Double>> pipeline = Arrays.asList(new Pair<>(flipTransform1,0.9),
                new Pair<>(flipTransform2,0.8),
                new Pair<>(warpTransform,0.5));

        ImageTransform transform = new PipelineImageTransform(pipeline,shuffle);

        /*Data Normalization*/
        DataNormalization scaler = new ImagePreProcessingScaler(0,1);

        ImageRecordReader testRR = new ImageRecordReader(numRows, numCols, 1, labelMaker);
        testRR.initialize(testData);
        testIter = new RecordReaderDataSetIterator(testRR, BATCH_SIZE, 1, outputNum);
        scaler.fit(testIter);
        testIter.setPreProcessor(scaler);

        ImageRecordReader trainRR = new ImageRecordReader(numRows, numCols, 1, labelMaker);
        trainRR.initialize(trainData, transform);
        DataSetIterator dataIter = new RecordReaderDataSetIterator(trainRR,batchSize,1,outputNum);
        scaler.fit(dataIter);
        dataIter.setPreProcessor(scaler);

        return dataIter;
    }

    /**
     * @param model - model to traing(MultilayerNetwork Java object).
     * @param data - DataSetIterator holding the training data.
     * @return a trained model(MultiLayerNetwork Java Object).
     */
    private MultiLayerNetwork train(MultiLayerNetwork model, DataSetIterator data,boolean pretrain) throws IOException
    {
        /* Score
         * -----------------------------------------------------------
         * This collects information, such as the loss, from the neural network and outputs them after a certain number of iterations.
         */
        /*model.setListeners(
                            new ScoreIterationListener(1)
                            );*/

        /*Then add the EvaluativeListener to print out the accuracy after each iteration*/
        /*model.setListeners(
                            new EvaluativeListener(testIter, 1)
                            );*/

        /*Then add the StatsListener to collect this information from the network, as it trains*/
        model.setListeners(
                            new StatsListener(
                                    statsStorage,
                                    1
                            )
        );

        /*Attach the StatsStorage instance to the UI: this allows the contents of the StatsStorage to be visualized*/
        uiServer.attach(statsStorage);

       /* File parentPath = new File(
                System.getProperty("user.dir"),
                "\\src\\main\\java\\ga\\teamgammma\\ai" + (pretrain ? "\\pretraining\\" : "\\training\\")
        );*/


        if(new File("//model//NeuralNetworkConfiguration.zip").exists())
        {
            model = ModelSerializer.restoreMultiLayerNetwork(new File("//model//NeuralNetworkConfiguration.zip"));
        }else{
            model.init();
        }
        Evaluation eval;
        long t1 = System.currentTimeMillis();
        for (int i = 0; i < NUM_EPOCHS; i++)
        {
            model.fit(data);
            //eval = model.evaluate(data);
            eval = model.evaluate(testIter);
            System.out.println(eval.stats(true));
        }
        long t2 = System.currentTimeMillis();
        long time = t2 - t1;
        ModelSerializer
                .writeModel(
                        model,
                        new File( "//model//NeuralNetworkConfiguration.zip"),
                        true
                );
        System.out.println("Done training, took: " + time + "ms");

        /*
        File imageFile = new File("C:\Users\..."); //Image location
        NativeImageLoader loader = new NativeImageLoader(100, 100, 1);
        INDArray image = loader.asMatrix(imageFile);
        ImagePreProcessingScaler preProcessor = new ImagePreProcessingScaler(0, 1);
        preProcessor.transform(image);
        INDArray out = model.output(image, false);
        System.out.println(out);

        Double max = out.amaxNumber().doubleValue();
        int index = -1
        for(int i = 0; i < 12; i++)
        {
            if(out.getDouble(i) == max || max.equals(out.getDouble(i)))
            {
                index = i;
                break;
            }
        }
        index++;
        System.out.println(index);
        */
        if(!pretrain){
            System.out.println("Purging directory");
            purgeDirectory( new File("//data//training//"));
            System.out.println("Done Purging...");
        }

        return model;
    }
}
