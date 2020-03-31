package ga.teamgamma.ai.NeuralNetworks;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import java.io.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author Aaron Phillip Facoline
 */

@SpringBootApplication
@RestController
public class NeuralNetworksApplication {

    public static void main(String[] args) {
        SpringApplication.run(NeuralNetworksApplication.class, args);
    }

    
    /**
     * @param mouth0_0 first spectrogram for "A", "E", "I" sound.
     * @param mouth0_1 second spectrogram for "A", "E", "I" sound.
     * @param mouth0_2 third spectrogram for "A", "E", "I" sound.
     * @param mouth1_0 first spectrogram for "L" sound.
     * @param mouth1_1 second spectrogram for "L" sound.
     * @param mouth1_2 third spectrogram for "L" sound.
     * @param mouth2_0 first spectrogram for "O" sound.
     * @param mouth2_1 second spectrogram for "O" sound.
     * @param mouth2_2 third spectrogram for "O" sound.
     * @param mouth3_0 first spectrogram for "C", "D", "G", "K", "N", "S", "T", "X", "Y", "Z" sound.
     * @param mouth3_1 second spectrogram for "C", "D", "G", "K", "N", "S", "T", "X", "Y", "Z" sound.
     * @param mouth3_2 third spectrogram for "C", "D", "G", "K", "N", "S", "T", "X", "Y", "Z" sound.
     * @param mouth4_0 first spectrogram for "F", "V" sound.
     * @param mouth4_1 second spectrogram for "F", "V" sound.
     * @param mouth4_2 third spectrogram for "F", "V" sound.
     * @param mouth5_0 first spectrogram for "Q", "W" sound.
     * @param mouth5_1 second spectrogram for "Q", "W" sound.
     * @param mouth5_2 third spectrogram for "Q", "W" sound.
     * @param mouth6_0 first spectrogram for "B", "M", "P" sound.
     * @param mouth6_1 second spectrogram for "B", "M", "P" sound.
     * @param mouth6_2 third spectrogram for "B", "M", "P" sound.
     * @param mouth7_0 first spectrogram for "U" sound.
     * @param mouth7_1 second spectrogram for "U" sound.
     * @param mouth7_2 third spectrogram for "U" sound.
     * @param mouth8_0 first spectrogram for "Ee" sound.
     * @param mouth8_1 second spectrogram for "Ee" sound.
     * @param mouth8_2 third spectrogram for "Ee" sound.
     * @param mouth9_0 first spectrogram for "R" sound.
     * @param mouth9_1 second spectrogram for "R" sound.
     * @param mouth9_2 third spectrogram for "R" sound.
     * @param mouth10_0 first spectrogram for "Th" sound.
     * @param mouth10_1 second spectrogram for "Th" sound.
     * @param mouth10_2 third spectrogram for "Th" sound.
     * @param mouth11_0 first spectrogram for "Ch", "J", "Sh" sound.
     * @param mouth11_1 second spectrogram for "Ch", "J", "Sh" sound.
     * @param mouth11_2 third spectrogram for "Ch", "J", "Sh" sound.
     * @return HttpStatus 200 OK if successful.
     * @throws IOException 
     */
    @PostMapping("/api/upload")
    public ResponseEntity<Object> apiUpload(@RequestParam("mouth0_0") MultipartFile mouth0_0, @RequestParam("mouth0_1") MultipartFile mouth0_1, @RequestParam("mouth0_2") MultipartFile mouth0_2,
            @RequestParam("mouth1_0") MultipartFile mouth1_0, @RequestParam("mouth1_1") MultipartFile mouth1_1, @RequestParam("mouth1_2") MultipartFile mouth1_2,
            @RequestParam("mouth2_0") MultipartFile mouth2_0, @RequestParam("mouth2_1") MultipartFile mouth2_1, @RequestParam("mouth2_2") MultipartFile mouth2_2,
            @RequestParam("mouth3_0") MultipartFile mouth3_0, @RequestParam("mouth3_1") MultipartFile mouth3_1, @RequestParam("mouth3_2") MultipartFile mouth3_2,
            @RequestParam("mouth4_0") MultipartFile mouth4_0, @RequestParam("mouth4_1") MultipartFile mouth4_1, @RequestParam("mouth4_2") MultipartFile mouth4_2,
            @RequestParam("mouth5_0") MultipartFile mouth5_0, @RequestParam("mouth5_1") MultipartFile mouth5_1, @RequestParam("mouth5_2") MultipartFile mouth5_2,
            @RequestParam("mouth6_0") MultipartFile mouth6_0, @RequestParam("mouth6_1") MultipartFile mouth6_1, @RequestParam("mouth6_2") MultipartFile mouth6_2,
            @RequestParam("mouth7_0") MultipartFile mouth7_0, @RequestParam("mouth7_1") MultipartFile mouth7_1, @RequestParam("mouth7_2") MultipartFile mouth7_2,
            @RequestParam("mouth8_0") MultipartFile mouth8_0, @RequestParam("mouth8_1") MultipartFile mouth8_1, @RequestParam("mouth8_2") MultipartFile mouth8_2,
            @RequestParam("mouth9_0") MultipartFile mouth9_0, @RequestParam("mouth9_1") MultipartFile mouth9_1, @RequestParam("mouth9_2") MultipartFile mouth9_2,
            @RequestParam("mouth10_0") MultipartFile mouth10_0, @RequestParam("mouth10_1") MultipartFile mouth10_1, @RequestParam("mouth10_2") MultipartFile mouth10_2,
            @RequestParam("mouth11_0") MultipartFile mouth11_0, @RequestParam("mouth11_1") MultipartFile mouth11_1, @RequestParam("mouth11_2") MultipartFile mouth11_2
            ) throws IOException {
        
        FileManager myfiles = new FileManager();
        
        myfiles.addFile(mouth0_0, "0");
        myfiles.addFile(mouth0_1, "0");
        myfiles.addFile(mouth0_2, "0");
        
        myfiles.addFile(mouth1_0, "1");
        myfiles.addFile(mouth1_1, "1");
        myfiles.addFile(mouth1_2, "1");

        myfiles.addFile(mouth2_0, "2");
        myfiles.addFile(mouth2_1, "2");
        myfiles.addFile(mouth2_2, "2");
        
        myfiles.addFile(mouth3_0, "3");
        myfiles.addFile(mouth3_1, "3");
        myfiles.addFile(mouth3_2, "3");
        
        myfiles.addFile(mouth4_0, "4");
        myfiles.addFile(mouth4_1, "4");
        myfiles.addFile(mouth4_2, "4");
        
        myfiles.addFile(mouth5_0, "5");
        myfiles.addFile(mouth5_1, "5");
        myfiles.addFile(mouth5_2, "5");
        
        myfiles.addFile(mouth6_0, "6");
        myfiles.addFile(mouth6_1, "6");
        myfiles.addFile(mouth6_2, "6");
        
        myfiles.addFile(mouth7_0, "7");
        myfiles.addFile(mouth7_1, "7");
        myfiles.addFile(mouth7_2, "7");
        
        myfiles.addFile(mouth8_0, "8");
        myfiles.addFile(mouth8_1, "8");
        myfiles.addFile(mouth8_2, "8");
        
        myfiles.addFile(mouth9_0, "9");
        myfiles.addFile(mouth9_1, "9");
        myfiles.addFile(mouth9_2, "9");
        
        myfiles.addFile(mouth10_0, "10");
        myfiles.addFile(mouth10_1, "10");
        myfiles.addFile(mouth10_2, "10");
        
        myfiles.addFile(mouth11_0, "11");
        myfiles.addFile(mouth11_1, "11");
        myfiles.addFile(mouth11_2, "11");
        
        return new ResponseEntity<>("Files successfully uploaded", HttpStatus.OK);
    }
    
    @GetMapping("/api/neuralNetwork")
     public File apiGetNN() {
        return NeuralNetwork.exportModel();
    }
}
