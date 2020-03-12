<?php
include('./config/connection.php');
header('Content-Type: application/json');
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Origin: http://localhost/api/");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");


class Register
{
    private $db;
    private $connection;
    function __construct()
    {
        $this->db = new Connection();
        $this->connection=$this->db->get_connection();
    }


    public function does_user_exist($name,$surname,$mail,$username,$pass)
    {
        $query = "SELECT * FROM User_Profile WHERE username='$username'";
        $result=mysqli_query($this->connection,$query);
        if(mysqli_num_rows($result)>0){
            $json['status']=400;
            $json['message']=' Sorry '.$username.' is already exist.';
            echo json_encode($json);
            mysqli_close($this->connection);
        }else {
            $query="insert into User_Profile(f_name,l_name,email,username,password) values('$name','$surname','$mail','$username','$pass')";
            $is_inserted=mysqli_query($this->connection,$query);
            if($is_inserted == 1){
                $json['status']=200;
                $json['message']='Account created, Welcome '.$name;
            }else {
                $json['status']=401;
                $json['message']='Something wrong';
            }
            echo json_encode($json);
            mysqli_close($this->connection);
        }
    }
}

$register = new Register();

$POST = json_decode(file_get_contents("php://input"));

if(!empty($POST)) {
    $name = $POST->f_name;
    $surname = $POST->l_name;
    $mail = $POST->email;
    $username = $POST->username;
    $pass = $POST->password;

    if
    (
        !empty($name) &&
        !empty($surname) &&
        !empty($mail) &&
        !empty($username) &&
        !empty($pass)
    )
    {

        //SOME SECURITY ALGORITHM
        $encrypted_password = md5($pass);
        $register->does_user_exist($name, $surname, $mail, $username, $encrypted_password);
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

?>