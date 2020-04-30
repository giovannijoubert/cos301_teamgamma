<!doctype html>
<html>

    <body>
        <form method="post">
            Send Test email<br>
            <input type="submit" name="testEmail" class="testEmail" value="testEmail"/>
           <!-- <input type="submit" name="testJson" class="testJson" value="testJson"/>
            <input type="submit" name="testBoth" class="testBoth" value="testBoth"/>
-->
        </form>
    function loadJson(){

        $myfile = fopen("notifications.json", "r") or die("Unable to open file!");
        $jsonData = "";
        while(!feof($myfile)) {
            $jsonData = fgets($myfile);
        }
        echo "1\n".$jsonData."\n";
        $jsonData = json_decode($jsonData);

        echo $jsonData[0];
        fclose($myfile);
    }
