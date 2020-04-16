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
            if(self::getName() != NULL)
                Update::setFName(self::getAuthkey(), self::getName());
                
            if(self::getLname() != NULL){}
                Update::setLName(self::getAuthkey(), self::getLName());
                
            if(self::getEmail() != NULL){
                $update = Update::setEmail(self::getAuthkey(), self::getEmail());
                if(json_decode($update)->status == "failure")
                    {
                        echo $update;
                        die();
                    }
            }
             
            if(self::getUsername() != NULL){
                $update = Update::setUsername(self::getAuthkey(), self::getUsername());
                if(json_decode($update)->status == "failure")
                    {
                        echo $update;
                        die();
                    }
            }
              

            if(self::getLM() != NULL)
                Update::setListeningMode(self::getAuthkey(), self::getLM());

            if(self::getTheme() != NULL)
                Update::setTheme(self::getAuthkey(), self::getTheme());
            
            if(self::getProfilePic() != NULL)
                Update::setProfilePic(self::getAuthkey(), self::getProfilePic());

            if(self::getCurrentMouthpack() != NULL)
                Update::setCurrentMouthpack(self::getAuthkey(), self::getCurrentMouthpack());

                //output new user profile
             echo Update::getUser(self::getAuthkey());
        }
    }
}
UpdateController::commitUpdate();

