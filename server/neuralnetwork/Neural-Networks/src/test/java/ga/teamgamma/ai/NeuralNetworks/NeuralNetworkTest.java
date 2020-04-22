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
    void lenetModel() {
        assertNotNull(new NeuralNetwork().lenetModel());
    }
}