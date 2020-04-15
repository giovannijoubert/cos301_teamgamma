<?php
// require_once '../config/config.php';
/*
 * Database Interface
 * Follows the Singleton Design Pattern
 */
class Database
{
    private  $connection;
    private static $instance = null;
    /*
     * Constructor, only accessible from within the class.
     * Has  functional side-effects.
     * @param none
     * @return void.
     */
    private function __construct()
    {
        try {
            $this->connection = new PDO("mysql:host=teamgamma.ga;dbname=teamgamma_usermanagementapi", "teamgamma_usermanagement", "xZE1UlkYA4");
            $this->connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $exception){
            echo ($exception->getMessage() . '\n' . $exception->getTraceAsString());
        }
    }
    /*
     * Returns the actual connection object, only is an confirmed to be a database connection object (PDO).
     * Has no functional side-effects.
     * @param none
     * @return PDO - connection instance.
     */

    public function getConnection(){
        if($this->connection instanceof PDO) {
            return $this->connection;
        }
    }
    /*
     * Gets an instance of a class. To be used in place of a constructor.
     * Has functional side-effects.
     * @param none
     * @return Database - An object of type Database.
     */
    public function getInstance(){
        if(self::$instance == null){
            self::$instance = new Database();
        }
        return self::$instance;
    }
    /*
     * Creates a table into the Mouthpiece Database, if not existing yet.
     * Has side-effects, however not internal to the program.
     * @param $table_name - A string containing the name of the new table.
     * @param $array - Lack of proper a name, an array containing a pair of attribute name and data type
     * @return void.
     */
    public function createTable($table_name, $array){
        $creation_string = "";
        foreach ($array as $attribute => $type){
            $creation_string .= $attribute . " " . $type . ",";
        }
        $creation_string = substr($creation_string, 0,-1);
        try {
            $query = $this->connection->prepare("CREATE TABLE $table_name ($creation_string);");
            print_r($query);
            $query->execute();
            while ($row = $query->fetch(PDO::FETCH_ASSOC)){
                var_export($row);
            }
        }
        catch (PDOException $exception){
            print_r($exception->getMessage());
        }
    }
    public function registerUser($username,$fname, $lname,$password, $email, $authkey){
        try {
            $query = $this->connection->prepare("INSERT INTO Users (username, f_name, l_name, password, email, authkey) values (?, ?,?,?,?,?)");
            $query->execute([$username,$fname, $lname, $password,  $email, $authkey]);
            $query = null;
            return json_encode(array("status" => "success", "message" => "User Registered."));
        } catch (PDOException $exception){
            if($exception->errorInfo[1] === 1062 ){
                 $message = $exception->getMessage();
                 if(strpos($message, 'email')){
                     return json_encode(array("status" => "failure", "message"=>"Email already exists."));
                 }
                 if(strpos($message, 'username')){
                    return json_encode(array("status" => "failure", "message"=>"Username already exists."));
                 }
                 if(strpos($message, 'authkey')){
                    return json_encode(array("status" => "failure", "message"=>"Auth Key already exists."));
                 }
            }
            echo ($exception->getMessage() . "\n");
        }
        return 0;
    }
    public function getUserByUsername($username){
        try {
            $query = $this->connection->prepare("SELECT * FROM Users WHERE username = ?");
            $query->execute([$username]);
            $user = $query->fetch(PDO::FETCH_ASSOC); 
            if($user ){
                print_r($user);
                return json_encode(array("status"=> "success", "user"=> ($user)));
            }
            else                 
                return json_encode(array("status" => "failure", "message"=> "User Not Found." ));
        } catch (PDOException $exception){
                echo($exception->getMessage());
        }
    }
    public function getUserById($uid){
        try {
            $query = $this->connection->prepare("SELECT * FROM Users WHERE user_id = ?");
            $query->execute([$uid]);
            $user = $query->fetch(PDO::FETCH_ASSOC); 
            if($user)
            return json_encode(array("status"=> "success", "user"=> ($user)));
            else 
                return json_encode(array("status" => "failure", "message"=> "User Not Found." ));
           
        } catch (PDOException $exception){
                echo($exception->getMessage());
        }
    }
    public function getMouthPackByUsername($username){
        try {
            $uid = $this->getUserByUsername($username);
            if($uid === 1)
                return 1;
            $uid = json_decode($uid, true);
            $uid = $uid['user_id'];
            echo($uid);
            $query = $this->connection->prepare("SELECT * FROM UserMouthpack WHERE user_id = ?");
            $query->execute([$uid]);
            $mouthpack = $query->fetch(PDO::FETCH_ASSOC); 
            if($mouthpack)
                return json_encode(array("status" => "success", "mouthpack" => ($mouthpack)));
            else return json_encode(array("status" => "failure", "message" => "Mouthpack not found"));
           print_r(($user));
           
        } catch (PDOException $exception){
                echo($exception->getMessage());
        }
    }
    public function setPassword($username, $password){
        try {
            $user = $this->getUserByUsername($username);
            if($user === 1)
                return json_encode(array("status" => "failure"));
            $user = json_decode($user, true);
            $query = $this->connection->prepare("UPDATE Users SET password = ? WHERE username = ?");
            $query->execute([$password, $username]);
            return json_encode(array("status" => "success", "user" => json_decode($this->getUserByUsername($username))->user));
        } catch(PDOException $exception){
            echo($exception->getMessage());

        }
    }
    public function getUserByAuthKey($authkey){
        try {
            $query = $this->connection->prepare("SELECT * FROM Users WHERE authkey = ?");
            $query->execute([$authkey]);
            $user = $query->fetch(PDO::FETCH_ASSOC); 
            print_r($user);
            if($user){
                return json_encode(array("status" => "success", "user" => $user));
            }
            return json_encode(array("status" => "failure"));
        } catch(PDOException $exception){
            echo($exception->getMessage());
        }
    }
    public function setTheme($username, $theme){
        try {
            $user = $this->getUserByUsername($username);
            if($user === 1)
                return json_encode(array("status" => "failure"));
            $user = json_decode($user, true);
            $query = $this->connection->prepare("UPDATE Users SET theme = ? WHERE username = ?");
            $query->execute([$theme, $username]);
            return json_encode(array("status" => "success", "user" => json_decode($this->getUserByUsername($username))->user));
        }
        catch(PDOException $exception){
            echo($exception->getMessage());
        }

    }
    public function setListeningMode($username, $listeningMode){
        try {
            $user = $this->getUserByUsername($username);
            if($user === 1)
                return json_encode(array("status" => "failure"));
            $user = json_decode($user, true);
            $query = $this->connection->prepare("UPDATE Users SET listening_mode = ? WHERE username = ?");
            $query->execute([$listeningMode, $username]);
    
            return json_encode(array("status" => "success", "user" => json_decode($this->getUserByUsername($username))->user));
        } catch(PDOException $exception){
            echo($exception->getMessage());

        }
    }
    
    public function setProfileImage($username, $profileImage){
        try {
            $user = $this->getUserByUsername($username);
            if($user === 1)
                return json_encode(array("status" => "failure"));
            $user = json_decode($user, true);
            $query = $this->connection->prepare("UPDATE Users SET profile_image = ? WHERE username = ?");
            $query->execute([$profileImage, $username]);
            return json_encode(array("status" => "success", "user" => json_decode($this->getUserByUsername($username))->user));
        }
        catch(PDOException $exception){
            echo($exception->getMessage());
        }

    }
    public function createMouthpack($user_id, $mouthpack_id,  $user_type, $background_color){
        try {
            $user = $this->getUserById($user_id);
            if(json_decode($user)->status === "failure"){
                return $user;
            }
            $query = $this->connection->prepare("INSERT INTO UserMouthpack (user_id, mouthpack_id, user_type, background_colour) VALUES(
                ?, ? ,?, ?)");
            $query->execute([$user_id, $mouthpack_id, $user_type, $background_color]);
            $query = null;
            $query = $this->connection->prepare("SELECT * from UserMouthpack WHERE user_id = ?");
            $query->execute([$user_id]);
            $mouthpack = $query->fetch(PDO::FETCH_ASSOC);
            if($mouthpack){
                return json_encode(array("status" => "success", "mouthpack" => $mouthpack));
            }
            return json_encode(array("status" => "failure", "message" => "Something went wrong"));
            
        } catch(PDOException $exception){
            if($exception->errorInfo[1] == 1062){
                $message = $exception->getMessage();
                return json_encode(array("status" => "failure", "message"=>$message));
                 
            }
            echo($exception->getMessage());
        }
    }
    public function checkOwnership($username, $mouthpack_id){
        $mouthpack = $this->getMouthPackByUsername($username, $mouthpack_id);
        if(json_decode($mouthpack)->status === "failure"){
            return json_encode(array("status" => "failure", "message" => "Mouthpack not found."));
        }
        $user_id = $this->getUserByUsername($username);
        if(!$user_id)
            return json_encode(array("status" => "failure", "message" => "User Not found."));
        if(json_decode($mouthpack)->user_id === $user_id)
            return json_encode(array("status" => "success", "result" => "true"));
        return json_encode(array("status" => "failure", "result" => "false"));
 
    }
    public function deleteMouthpack($username, $mouthpack_id){
        if(json_decode($this->checkOwnership($username, $mouthpack_id))->status === "success"){
            $query = $this->connection->prepare("DELETE FROM UserMouthpack WHERE mouthpack_id = ?");
            $query->execute([$mouthpack_id]);
            return json_encode(array("status" => "success", "message" => "Mouthpack Deleted."));
        }
        return json_encode(array("status" => "failure", "message"=>"User does not own mouthpack"));
    }
    

}

$db = Database::getInstance();
echo(($db->createMouthpack("1234567898","", "", "")) . "\n");
