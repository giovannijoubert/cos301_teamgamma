import 'package:permission_handler/permission_handler.dart';



class permissionRequest{


  final PermissionHandler _permissionHandler = PermissionHandler();


    // Template code to access permissions
    Future<bool> _requestPermission(PermissionGroup permission) async {
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }    return false;
  }

  // Important note: permissions listed below are just for android, need to do something like
  // Platform.isAndroid ? : to sort out for iOS permissions

  // Specific code to request permissions 
   Future<bool> requestMicrophonePermission() async {
    return _requestPermission(PermissionGroup.microphone);
   }

    Future<bool> requestStoragePermission() async {
    return _requestPermission(PermissionGroup.storage);
  }

  


   // Template code to check if app hasPermission
    Future<bool> hasPermission(PermissionGroup permission) async {
    var permissionStatus =
        await _permissionHandler.checkPermissionStatus(permission);
    return(permissionStatus == PermissionStatus.granted);
    
  }
  // Specific code to check hasPermission
  Future<bool> hasMicrophonePermission() async {
    return hasPermission(PermissionGroup.microphone);
  }
    
  Future<bool> hasStoragePermission() async {
    return hasPermission(PermissionGroup.storage);
  }

}