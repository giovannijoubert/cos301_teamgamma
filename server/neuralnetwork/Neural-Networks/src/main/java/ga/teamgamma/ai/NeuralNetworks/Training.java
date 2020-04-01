package ga.teamgamma.ai.NeuralNetworks;
import org.datavec.api.io.filters.BalancedPathFilter;
import org.datavec.api.io.labels.ParentPathLabelGenerator;
import org.datavec.api.split.FileSplit;
import org.datavec.image.loader.NativeImageLoader;
import org.datavec.image.recordreader.ImageRecordReader;
import org.datavec.image.transform.FlipImageTransform;
import org.datavec.image.transform.ImageTransform;
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
import org.nd4j.linalg.dataset.DataSet;
import org.nd4j.linalg.dataset.api.iterator.DataSetIterator;
import org.nd4j.linalg.dataset.api.preprocessor.DataNormalization;
import org.nd4j.linalg.dataset.api.preprocessor.ImagePreProcessingScaler;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Arrays;
import java.util.List;
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
    private int numRows = 100,
                numCols = 100,
                outputNum = 12,
                numSamples = 36,//3 samples per formant, 12 formants
                batchSize = 100;

    /**
     * PRE-TRAINING
     */

    private int NUM_ROWS = 100,
                NUM_COLUMNS = 100,
                OUTPUT_NUMS = 12,//number of output classes
                BATCH_SIZE = 10,//batch size for each epoch
                RNG_SEED = 123,
                NUM_EPOCHS = 10;//number of epochs to perform

    private  double RATE = 0.0015;//learning rate

    DataSetIterator trainingIter;

    private Random rng = new Random(RNG_SEED);

    public Training()
    {
        /**Initialize the user interface backend*/
        uiServer = UIServer.getInstance();

        /**Configure where the network information (gradients, score vs. time etc) is to be stored. Here: store in memory*/
        statsStorage = new InMemoryStatsStorage(); //Alternative: new FileStatsStorage(File), for saving and loading later.
    }

    public MultiLayerNetwork train(boolean pretrain, MultiLayerNetwork model)
    {
        try
        {
            return train(model, getTrainingDataSetIterator(pretrain));
        }
        catch(Exception e)
        {
            System.err.println("Error Training: "+e.getMessage());
        }

        return null;
    }

    private List<ImageTransform> getTransforms(){
        return Arrays.asList(new ImageTransform[]{
                                                    new FlipImageTransform(rng),
                                                    new WarpImageTransform(rng,42),
                                                    new FlipImageTransform(new Random(123))
                                                });
    }

    private DataSetIterator getTrainingDataSetIterator(boolean pretrain) throws IOException
    {
        String path = System.getProperty("user.dir") + "\\src\\database.txt";
        /**Get Training Data Directory*/
        File parentPath = new File(
                                    System.getProperty("user.dir"),
                                    "\\src\\main\\java\\ga\\teamgammma\\ai" + (pretrain ? "\\pretraining\\" : "\\training\\")
        );
        System.out.println("Training Set Path: "+parentPath.toString());;

        ParentPathLabelGenerator labelMaker = new ParentPathLabelGenerator();
        FileSplit trainData = new FileSplit(parentPath, NativeImageLoader.ALLOWED_FORMATS, rng);

        /**Ensure Training Data is Distributed Equally amongst the various labels*/
        BalancedPathFilter pathFilter = new BalancedPathFilter(rng, labelMaker, numSamples, outputNum, batchSize);


        ImageRecordReader recordReader = new ImageRecordReader(numRows,numCols,outputNum,labelMaker);
        recordReader.initialize(trainData);
        /**Add Transformed Data To Pretraing On*/
        for (ImageTransform transform : getTransforms()){
            recordReader.initialize(trainData,transform);
        }
        /**Data Normalization*/
        DataNormalization scaler = new ImagePreProcessingScaler(0,1);
        DataSetIterator dataIter = new RecordReaderDataSetIterator(recordReader,batchSize,1,outputNum);
        scaler.fit(dataIter);
        dataIter.setPreProcessor(scaler);

        return dataIter;
    }


    private MultiLayerNetwork train(MultiLayerNetwork model, DataSetIterator data) throws IOException
    {
        model.init();

        /**Score
         * -----------------------------------------------------------
         * This collects information, such as the loss, from the neural network and outputs them after a certain number of iterations.
         * */
        model.setListeners(
                            new ScoreIterationListener(5)
                            );

        /**Then add the EvaluativeListener to print out the accuracy after each iteration*/
        model.setListeners(
                            new EvaluativeListener(data, 1, InvocationType.EPOCH_END)
                            );

        /**Then add the StatsListener to collect this information from the network, as it trains*/
        model.setListeners(
                            new StatsListener(
                                    statsStorage,
                                    1
                            )
        );

        /**Attach the StatsStorage instance to the UI: this allows the contents of the StatsStorage to be visualized*/
        uiServer.attach(statsStorage);

       /* File parentPath = new File(
                System.getProperty("user.dir"),
                "\\src\\main\\java\\ga\\teamgammma\\ai" + (pretrain ? "\\pretraining\\" : "\\training\\")
        );*/
        if(new File("../NeuralNetworkConfiguration.zip").exists())
        {
            model = ModelSerializer.restoreMultiLayerNetwork(new File("../NeuralNetworkConfiguration.zip"));
        }
        else
        {
            for (int i = 0; i < NUM_EPOCHS; i++)
            {
                model.fit(data);
            }
            ModelSerializer
                    .writeModel(
                            model,
                            new File( "../NeuralNetworkConfiguration.zip"),
                            true
                    );

        }

        Evaluation eval = model.evaluate(data);
        System.out.println(eval.stats(true));
        return model;
    }
}
