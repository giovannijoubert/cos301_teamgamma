<?php

require 'includes/models/ResponseObject.php';

class routeManager
{
    public function getRoute($uri)
    {
        /**
         * Authorize here before access to to api resources
         * If failure to authorize respond Unauthorized -> ResponseObject error401()
         *
         */
        switch (explode('.',$uri)[0]) {
            case 'register' :
                require 'includes/controllers/RegisterController.php';
                break;
            case 'login' :
                require 'includes/controllers/LoginController.php';
                break;
            case 'logout' :
                require 'includes/controllers/LogOutController.php';
                break;
            case 'update' :
                require 'includes/controllers/UpdateController.php';
                break;
            case 'recover' :
                require 'includes/controllers/RecoverController.php';
                break;
            case 'delete' :
                require 'includes/controllers/DeleteController.php';
                break;
            case 'reset' :
                require 'includes/controllers/ResetController.php';
                break;
            case 'addmouthpack' :
                require 'includes/controllers/AddMouthpackController.php';
                break;
            default:
                ResponseObject::error404();
                break;
        }
    }
}