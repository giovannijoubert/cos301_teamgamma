<?php
require_once 'config.php';

class Connection{
    private $connect;
    function __construct(){
        $this->connect=mysqli_connect(hostname,user,password,db_name) or die("MySQL Connection error.");
    }
    public function get_connection()
    {
        return $this->connect;
    }
}
?>