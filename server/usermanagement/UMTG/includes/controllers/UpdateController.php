<?php
require_once 'Controller.php';
require_once 'includes/models/Update.php';
require_once 'includes/models/ResponseObject.php';

class UpdateController extends Controller{
    public static function commitUpdate()
    {
        //authenticate via authkey
        if(json_decode(Update::getUser(self::getAuthkey()))->status != "success") {
            ResponseObject::error401a();
        } else {
            if(Controller::getName() != NULL)
                Update::setFName(self::getAuthkey(), Controller::getName());
                
            if(Controller::getLname() != NULL){}
                Update::setLName(self::getAuthkey(), Controller::getLName());
                
            if(Controller::getEmail() != NULL){
                $update = Update::setEmail(self::getAuthkey(), Controller::getEmail());
                if(json_decode($update)->status == "failure")
                    {
                        echo $update;
                        die();
                    }
            }
             
            if(Controller::getUsername() != NULL){
                $update = Update::setUsername(self::getAuthkey(), Controller::getUsername());
                if(json_decode($update)->status == "failure")
                    {
                        echo $update;
                        die();
                    }
            }
              

            if(Controller::getLM() != NULL)
                Update::setListeningMode(self::getAuthkey(), Controller::getLM());

            if(Controller::getTheme() != NULL)
                Update::setTheme(self::getAuthkey(), Controller::getTheme());
            
            if(Controller::getProfilePic() != NULL)
                Update::setProfilePic(self::getAuthkey(), Controller::getProfilePic());

            echo Update::getUser(self::getAuthkey());
        }
    }
}
UpdateController::commitUpdate();

