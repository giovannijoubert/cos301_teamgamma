<?php

define("SERVER","teamgamma.ga");
define("USER","teamgamma_ga");
define("PASSWORD","KnEdBAr0vH2");
define("DB","teamgamma_sharingapi");

$mysql = new mysqli(SERVER,USER,PASSWORD,DB);

$response = array();

//////test database connection
if($mysql->connect_error){

 $response["MESSAGE"] = "ErroR in Server";
 $response["STATUS"] = 500;

} 
else{       /////////////////////////////call api functionalities


  if ($_POST["mouthCount"]="singleMouth"  &&  $_POST["mouthCount"]="singleMouth")    //UPLOAD SINGLE MOUTH;
  {
                 if(is_uploaded_file($_FILES["imageURL"]["tmp_name"]) && @$_POST["name"] )
                  {
                                     $tmp_file = $_FILES["imageURL"]["tmp_name"];
                                      $img_name = $_FILES["imageURL"]["name"];
                                      //////try make folder if it doesnt exist --for a pack
                                      if (!file_exists('../mouthpacks/'.$_POST["name"])) {
                                        mkdir('../mouthpacks/'.$_POST["name"], 0777, true);
                                    }
                                      $upload_dir = "../mouthpacks/".$_POST["name"]."/".$img_name;
                                      $id=rand();
                                      $sql = "INSERT INTO MockTable(name,author,imageURL,id,ratings) VALUES ('{$_POST["name"]}','{$_POST["author"]}','{$upload_dir}','{$id}','{$_POST["ratings"]}')";

                                      if(move_uploaded_file($tmp_file, $upload_dir) && $mysql->query($sql)){

                                       $response["MESSAGE"] = "Upload Success ";
                                       $response["STATUS"] = 200;                                       
                                      }else{
                                       $response["MESSAGE"] = "Upload Failed ";
                                       $response["STATUS"] = $mysql-> error;
                                      }
                    }
                    else{

                                      $response["MESSAGE"] = "Invalid Request -400";
                                      $response["STATUS"] = 400;

                    }
                     echo json_encode($response);
  }
  else{

                                     $response["MESSAGE"] = "Invalid Request -----400";
                                      $response["STATUS"] = 400;

  }

 }


?>