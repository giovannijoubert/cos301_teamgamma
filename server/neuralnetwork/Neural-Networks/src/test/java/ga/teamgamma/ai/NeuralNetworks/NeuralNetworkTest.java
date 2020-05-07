package ga.teamgamma.ai.NeuralNetworks;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class NeuralNetworkTest
{
    @Test
    void exportModel() {
        assertNotNull(new NeuralNetwork().exportModel());
    }

    // @Test
    // void alexnetModel() { assertNotNull(new NeuralNetwork().alexnetModel()); }

    @Test
    void lenetModelMNist()
    {
        assertNotNull(new NeuralNetwork().lenetModel(true));
    }

    @Test
    void lenetModelOwn()
    {
        assertNotNull(new NeuralNetwork().lenetModel(false));
    }
}