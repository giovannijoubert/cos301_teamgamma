<?php
//server connection details -- can be in a separate file ?
header("Access-Control-Allow-Origin: *");
header('Content-type:application/json');

$server = "teamgamma.ga";
$username = "teamgamma_ga";
$pw = "KnEdBAr0vH2";
$db = "teamgamma_sharingapi";
$data = array();

//connection
$conn = mysqli_connect($server,$username,$pw,$db);

//receive http POST request
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON);
$type = $input->requestType;


if (!$conn) { //test if connection failed
	http_response_code(500);
	$newObj = ["message"=>"connection failed: ".mysqli_connect_error()];
	array_push($data,$newObj);
	echo json_encode($data);
} else { //test was successful
	//check request type
	if ($type == "getMouthPack") { //request mouth pack
		if (!array_key_exists("name",$input)) {
			http_response_code(400);
			$newObj = ["message"=>"Mouth Pack request does not contain a name parameter"];
			array_push($data,$newObj);
			echo json_encode($data);
			exit;
		}
		$id = $input->name;
		$sql = "SELECT * FROM MockTable where name='".$id."'";
	} else if ($type == "getMouth") { //request single mouth
		if (!array_key_exists("id",$input)) {
			http_response_code(400);
			$newObj = ["message"=>"Mouth request does not contain an id parameter"];
			array_push($data,$newObj);
			echo json_encode($data);
			exit;
		}
		$id = $input->id;
		$sql = "SELECT * FROM MockTable where id='".$id."'";
	} else { // invalid request
		http_response_code(400);
		$newObj = ["message"=>"Invalid Request Type"];
		array_push($data,$newObj);
		echo json_encode($data);
		exit;
	}

	//if all tests succeed code will land up here
	$result = mysqli_query($conn,$sql);
	if (mysqli_num_rows($result) > 0) { //results were found in database
		while ($row = mysqli_fetch_assoc($result)) {
			$id = $row['id'];
			$name = $row['name'];
			$author = $row['author'];
			$date = $row['dateCreated'];
			$url = $row['imageURL'];
			$rate = $row['ratings'];
			$uploaded = $row['dateUploaded'];

			$newObj = ['id'=>$id,'name'=>$name,
				'author'=>$author,'dateCreated'=>$date,
				'imageURL'=>$url,'ratings'=>$rate,
				'dateUploaded'=>$uploaded];
			array_push($data,$newObj);
		}
		http_response_code(200);
		echo json_encode($data);
	} else { //no results were found in the database
		http_response_code(200);
		$newObj = ["message"=>"0 results found"];
		array_push($data,$newObj);
		echo json_encode($data);
	}
}

//close connection
mysqli_close($conn);
?>
