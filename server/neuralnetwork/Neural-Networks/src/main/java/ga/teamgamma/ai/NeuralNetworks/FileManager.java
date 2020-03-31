package ga.teamgamma.ai.NeuralNetworks;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author Aaron Phillip Facoline
 */
public class FileManager {

    public FileManager() {

    }
  
    /**
     * @param inputFile a MultipartFile object, this file will be writen to the folder listed in sound.
     * @param sound the destination folder for the inputFile to be writen to.
     * @throws IOException 
     */
    public void addFile(MultipartFile inputFile, String sound) throws IOException {
        File myFile = new File("/uploads/"+ sound +"/"+ genName(8) + inputFile.getOriginalFilename());
        myFile.createNewFile();
        FileOutputStream output = new FileOutputStream(myFile);
        output.write(inputFile.getBytes());
        output.close();
    }
    
    private String genName(int n){
        String val = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvxyz";
        String myString = "";
        for (int i = 0; i < n; i++) { 
            int index = (int)(val.length() * Math.random());
            myString = myString + val.charAt(index);
        } 
        return myString; 
    }
}
