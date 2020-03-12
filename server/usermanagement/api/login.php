<?php
include('./config/connection.php');
//include './config/core.php';
//include_once 'libs/php-jwt-master/src/BeforeValidException.php';
//include_once 'libs/php-jwt-master/src/ExpiredException.php';
//include_once 'libs/php-jwt-master/src/SignatureInvalidException.php';
//include_once 'libs/php-jwt-master/src/JWT.php';
//use \Firebase\JWT\JWT;

header('Content-Type: application/json');
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Origin: http://localhost/api/");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");


class Login
{
    private $db;
    private $connection;
    function __construct()
    {
        $this->db = new Connection();
        $this->connection=$this->db->get_connection();
    }

//    public function getJWT($user_id,$f_name,$l_name,$email,$username)
//    {
//        $token = array(
//            "iss" => $iss,
//            "aud" => $aud,
//            "iat" => $iat,
//            "nbf" => $nbf,
//            "data" => array(
//                "user_id" => $user_id,
//                "f_name" => $f_name,
//                "l_name" => $l_name,
//                "email" => $email,
//                "username" => $username
//            )
//        );
//        return $token;
//    }

    public function does_user_exist($username,$pass)
    {
        $query = "SELECT * FROM User_Profile WHERE username='$username'";
        $result=mysqli_query($this->connection,$query);
        if(!(mysqli_num_rows($result)>0)){
            $json['status']=400;
            $json['message']=' Sorry '.$username.' does not exist.';
            echo json_encode($json);
            mysqli_close($this->connection);
        }
        else
        {
            $row = mysqli_fetch_assoc($result);
            if($row['password']==$pass)
            {
                $json['status']=200;
                $json['message']='Access granted, Welcome ';
                $json['user_id'] = $row['user_id'];
                $json['f_name'] = $row['f_name'];
                $json['l_name'] = $row['l_name'];
                $json['email'] = $row['email'];
                $json['username'] = $row['username'];
            }
            else
            {
                $json['status']=401;
                $json['message']='Incorrect password';
            }
            echo json_encode($json);
            mysqli_close($this->connection);
        }
    }
}

$login = new Login();
//FOR WEB CALLS

//FOR APP CALLS

$POST = json_decode(file_get_contents("php://input"));
if(!empty($POST)) {
    $username = $POST->username;
    $pass = $POST->password;
    if
    (
        !empty($username) &&
        !empty($pass)
    )
    {
        //DO SOME SECURITY ALGORITHM
        $encrypted_password = md5($pass);
        $login->does_user_exist($username, $encrypted_password);
    }
    else
    {
        $json['status'] = 100;
        $json['message'] = 'You must fill all the fields';
        echo json_encode($json);
    }
}
else
{
    $json['status'] = 100;
    $json['message'] = 'You must fill all the fields';
    echo json_encode($json);
}



// generate json web token



?>