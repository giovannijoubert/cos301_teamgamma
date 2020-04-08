<?php

    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Credentials: true");
    header('Access-Control-Allow-Methods: *');
    header('Access-Control-Allow-Headers: *');
    header("Content-Type: *");

	define("SERVER","teamgamma.ga");
	define("USER","teamgamma_ga");
	define("PASSWORD","KnEdBAr0vH2");
	define("DB","teamgamma_sharingapi");

	$downloadData = array();
	$mysql = new mysqli(SERVER,USER,PASSWORD,DB);

	//connection
	$conn = mysqli_connect(SERVER,USER,PASSWORD,DB);

	$response = array();

	//test database connection
	if($mysql->connect_error)
	{
		$response["MESSAGE"] = "Error in Server";
		$response["STATUS"] = 500;
	}

	if (!$conn) 
	{ //test if connection failed
		http_response_code(500);
		$newObj = ["message"=>"connection failed: ".mysqli_connect_error()];
		array_push($downloadData,$newObj);
		echo json_encode($downloadData);
	}

	if (!mysqli_options($conn,MYSQLI_OPT_CONNECT_TIMEOUT,60)) 
	{
		http_response_code(500);
		$newObj = ["message"=>"connection failed: ".mysqli_connect_error()];
		array_push($downloadData,$newObj);
		echo json_encode($downloadData);
		exit;
	}

	//get the post data
	$incoming = $_SERVER["CONTENT_TYPE"];
	if ($incoming != "application/json")
	{      //didnt send json data
		http_response_code(500);
		$sender = ["message"=>"Internal Server Error - send json data"];
		array_push($response,$sender);
		echo json_encode($response);

	}

    else
	{
   	    $content = trim(file_get_contents('php://input'));
        $data = json_decode($content,true); 

        /****************
            UPLOAD
        ****************/
        if( $data["requestType"] == "upload")
        {	//try make folder if it doesnt exist --for a pack
		    if (!file_exists('../mouthpacks/'.$data["title"]))
			{
				mkdir('../mouthpacks/'.$data["title"], 0777, true);
            }

            //send Mouthpack datails to db
			$packid=rand(); 
			$packname=$data["title"];
			$packdescription=$data["description"];
			$packdate=date("Y/m/d");
			$sql2 = "INSERT INTO Mouthpack(mouthpack_id,mouthpack_name,description,date) VALUES ('{$packid}','{$packname}','{$packdescription}','{$packdate}')";
			$catid=rand();
			$catname=$data["category"];
			$sql3 = "INSERT INTO Category(category_id,category_name) VALUES ('{$catid}','{$catname}')";
			$sql4 = "INSERT INTO MouthpackCategory(category_id,mouthpack_id) VALUES ('{$catid}','{$packid}')";

            //send data to Mouthpack, mouthpackCategory and Category
			if($mysql->query($sql2) && $mysql->query($sql3 ) && $mysql->query($sql4 ))
            {   
                //upload each image and send details to db 
                foreach ($data["mouthImages"] as $datas)
                {
                    $d = explode( ',', $datas["imageData"] );
                    $filename_path = md5(time().uniqid()).".jpg"; 
                    $decoded=base64_decode($d[1]);
                    $imageurl="../mouthpacks/".$data["title"]."/";
                    $destination_img = $imageurl.$filename_path;
                    $comp = standardiseImage($d[1]);
                        
                    $imageid=$data["title"].rand();
                    $imagePath="http://teamgamma.ga/mouthpacks/".$data["title"]."/".$filename_path;

                    $sql1 = "INSERT INTO MouthImage(image_id,image_URL) VALUES ('{$imageid}','{$imagePath}')";
                        
                    if(imagejpeg($comp, $destination_img, 90) && $mysql->query($sql1))
                    {
                        $myObj = new stdClass(); 
                        $myObj->status = "200 Ok";
                        $myObj->extra = $imagePath;
                        $myObj->message="MouthPack ".$data["title"]." uploaded correctly";
                        $myJSON = json_encode($myObj); 
                        echo $myJSON;
                    }

                    else
                    {
                        $myObj = new stdClass();
                        $myObj->message="Image not uploaded correctly";
                        $myJSON = json_encode($myObj);   
                        echo $myJSON;
                    }
                } ///end of for loop
            }
			else
			{
                $myObj = new stdClass();
                $myObj->error =$mysql -> error;
                $myObj->message="MouthPack details invalid - images not uploaded";
                $myJSON = json_encode($myObj); 
                echo $myJSON;
			}
        }

        /****************
            DOWNLOAD
        ****************/
        else if ($data["requestType"] == "getMouthPack")
        {
            header("Content-type:application/json");
            if (!array_key_exists("id",$data)) 
            {
                http_response_code(400);
                $newObj = ["message"=>"Mouth Pack request does not contain an id parameter"];
                array_push($downloadData,$newObj);
                echo json_encode($downloadData);
                exit;
            }

            $id = $data["id"];
            $sql = "SELECT * FROM Mouthpack where mouthpack_id='".$id."'";

            $result = mysqli_query($conn,$sql);
            if (mysqli_num_rows($result) > 0) 
            { //results were found in database
                while ($row = mysqli_fetch_assoc($result)) 
                {
                //details from mouthpack table
                $id = $row['mouthpack_id'];
                $name = $row['mouthpack_name'];
                $descr = $row['description'];
                $date = $row['date'];
                $categories = array();
                $images = array();
                $ratings = array();

                //get categories
                $MPCQuery = "SELECT * FROM MouthpackCategory WHERE mouthpack_id='".$id."'";
                $MPCResult = mysqli_query($conn,$MPCQuery); //execute query to get mouthpackcategory
                if (mysqli_num_rows($MPCResult) > 0) 
                {
                    while ($MPCRow = mysqli_fetch_assoc($MPCResult)) 
                    {
                        $catID = $MPCRow["category_id"];
                        $CatQuery = "SELECT * FROM Category WHERE category_id='".$catID."'";

                        $CatResult = mysqli_query($conn,$CatQuery);
                        if (mysqli_num_rows($CatResult) > 0) 
                        {
                            while ($CatRow = mysqli_fetch_assoc($CatResult)) 
                            {
                                array_push($categories,$CatRow["category_name"]);
                            }
                        }
                    }
                }

                //get image urls
                $ImageQuery = "SELECT * FROM MouthImage WHERE mouthpack_id='".$id."'";
                $ImageResult = mysqli_query($conn,$ImageQuery); //execute query to get 
                if (mysqli_num_rows($ImageResult) > 0) 
                {
                    while ($ImageRow = mysqli_fetch_assoc($ImageResult)) 
                    {
                        array_push($images,$ImageRow["image_URL"]);
                    }
                }

                //get ratings
                $RateQuery = "SELECT * FROM Rating WHERE mouthpack_id='".$id."'";
                $RateResult = mysqli_query($conn,$RateQuery); //execute query to get 
                $rateUser;
                $rateValue;
                $rateTotal = 0;
                if (mysqli_num_rows($RateResult) > 0) 
                {
                    $i = 1;
                    while ($RateRow = mysqli_fetch_assoc($RateResult)) 
                    {
                        $rateUser = $RateRow["user_id"];
                        $rateValue = intval($RateRow["value"]);
                        $rateTotal = ($rateTotal + $rateValue)/$i;

                        $newRating = ["user_id"=>$rateUser,"value"=>$rateValue];
                        array_push($ratings,$newRating);
                        $i++;
                    }

                    $tot = ["total"=>$rateTotal];
                    array_unshift($ratings,$tot);
                }
              
                $newObj = ['id'=>$id,'name'=>$name,
                'description'=>$descr,'date'=>$date,
                'categories'=>$categories,'images'=>$images,'ratings'=>$ratings];
                array_push($downloadData,$newObj);
            }

            http_response_code(200);
            echo json_encode($downloadData);
            } 

            else 
            { //no results were found in the database
                http_response_code(200);
                $newObj = ["message"=>"0 results found"];
                array_push($downloadData,$newObj);
                echo json_encode($downloadData);
            }
        }

        else if ($data["requestType"] == "getAllMouthpacks")
        {
            header("Content-type:application/json");

            $sql = "SELECT * FROM Mouthpack";
            if (array_key_exists("filter",$data)) 
            { //filter results
                $sql .= " WHERE ".$data["filter"]["criteria"]. " LIKE '%".$data["filter"]["like"]."%'";
            }

            if (array_key_exists("sort_by",$data)) 
            { //criteria to sort by
                $sql .= " ORDER BY ".$data["sort_by"];
            }

            if (array_key_exists("order",$data)) 
            { //order to return in (ascending/descening)
                $sql .= " ".$data["order"];
            }

            $result = mysqli_query($conn,$sql);
            if (mysqli_num_rows($result) > 0) 
            { //results were found in database
                while ($row = mysqli_fetch_assoc($result)) 
                {
                    //details from mouthpack table
                    $id = $row['mouthpack_id'];
                    $name = $row['mouthpack_name'];
                    $descr = $row['description'];
                    $date = $row['date'];
                    $categories = array();
                    $images = array();
                    $ratings = array();

                    //get categories
                    $MPCQuery = "SELECT * FROM MouthpackCategory WHERE mouthpack_id='".$id."'";
                    $MPCResult = mysqli_query($conn,$MPCQuery); //execute query to get mouthpackcategory
                    if (mysqli_num_rows($MPCResult) > 0) 
                    {
                        while ($MPCRow = mysqli_fetch_assoc($MPCResult)) 
                        {
                            $catID = $MPCRow["category_id"];
                            $CatQuery = "SELECT * FROM Category WHERE category_id='".$catID."'";

                            $CatResult = mysqli_query($conn,$CatQuery);
                            if (mysqli_num_rows($CatResult) > 0) 
                            {
                                while ($CatRow = mysqli_fetch_assoc($CatResult)) 
                                {
                                    array_push($categories,$CatRow["category_name"]);
                                }
                            }
                        }
                    }

                    //get image urls
                    $ImageQuery = "SELECT * FROM MouthImage WHERE mouthpack_id='".$id."'";
                    $ImageResult = mysqli_query($conn,$ImageQuery); //execute query to get 
                    if (mysqli_num_rows($ImageResult) > 0) 
                    {
                        while ($ImageRow = mysqli_fetch_assoc($ImageResult)) 
                        {
                            array_push($images,$ImageRow["image_URL"]);
                        }
                    }

                    //get ratings
                    $RateQuery = "SELECT * FROM Rating WHERE mouthpack_id='".$id."'";
                    $RateResult = mysqli_query($conn,$RateQuery); //execute query to get 
                    $rateUser;
                    $rateValue;
                    $rateTotal = 0;

                    if (mysqli_num_rows($RateResult) > 0) 
                    {
                        $i = 1;
                        while ($RateRow = mysqli_fetch_assoc($RateResult)) 
                        {
                            $rateUser = $RateRow["user_id"];
                            $rateValue = intval($RateRow["value"]);
                            $rateTotal = ($rateTotal + $rateValue)/$i;

                            $newRating = ["user_id"=>$rateUser,"value"=>$rateValue];
                            array_push($ratings,$newRating);
                            $i++;
                        }
                        $tot = ["total"=>$rateTotal];
                        array_unshift($ratings,$tot);
                    }
                
                    $newObj = ['id'=>$id,'name'=>$name,
                    'description'=>$descr,'date'=>$date,
                    'categories'=>$categories,'images'=>$images,'ratings'=>$ratings];
                    array_push($downloadData,$newObj);
                }

                http_response_code(200);
                echo json_encode($downloadData);
            }

            else 
            { //no results were found in the database
                http_response_code(200);
                $newObj = ["message"=>"0 results found"];
                array_push($downloadData,$newObj);
                echo json_encode($downloadData);
            }
        }

        else 
        {
            http_response_code(400);
            $newObj = ["message"=>"Invalid Request Type"];
            array_push($downloadData,$newObj);
            echo json_encode($downloadData);
            exit;
        }
    }

    mysqli_close($conn);

    /****************
        Compression
    ****************/
  	function standardiseImage($b64)
  	{
		$data = base64_decode($b64); // Base64 to image string 
        $img = imagecreatefromstring($data); // Image string to actual image
        
		return $img;

	}
?>