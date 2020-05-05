import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mouthpiece/ui/shared/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'core/services/authentication/authentication_service.dart';
import 'locator.dart';
import 'ui/router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'core/models/user.dart';
import 'core/services/Permissions/permissionRequest.dart';
import 'dart:typed_data';
import 'package:file_utils/file_utils.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  // final prefs = await SharedPreferences.getInstance();
  runApp(
    // MouthPiece()
    ChangeNotifierProvider<ThemeChanger>(
      builder: (_) => ThemeChanger(lightTheme),
      child: new MouthPiece(),
    ),
  );
}

// changeTheme(BuildContext context) async {
//   final theme = Provider.of<ThemeChanger>(context);  
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   bool loggedIn = await getLoggedIn();
//   if (!loggedIn) 
//     theme.setTheme(lightTheme);
//   else
//     theme.setTheme(prefs.getString("theme") == "Light" ? lightTheme : darkTheme);  
// }


// ThemeChanger theme;

class MouthPiece extends StatefulWidget {
  // final ThemeChanger theme;
  // const MouthPiece(Key key, this.theme) : super(key: key);
  @override
  _MouthPieceState createState() => _MouthPieceState();
}

class _MouthPieceState extends State<MouthPiece> {

  Future<void> createDir() async {  // Creates default directory for mouthpacks as well as prepopulates from assets
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLogSet = prefs.getKeys().contains('loggedIn');
  if(!isLogSet)
    prefs.setBool('loggedIn', false);
          
  await requestPermission(); // get All permissions required from now
  // final String path = await _localPath;
  // final Directory dir = await Directory('$path/defaultMouthpacks').create(recursive: true);



    // print(dir.path+"/2-1.png");
    // Directory created now copy files over 2-1.png 2-6.png
    /* for(int j=1;j<5;j++){   // For whole pack
      for(int i=1;i<7;i++){   // For individuals
        if (FileSystemEntity.typeSync(dir.path+"/"+j.toString()+"-"+i.toString()+".png") == FileSystemEntityType.notFound) {
          print("Copying mouth "+j.toString()+"-"+i.toString()+" to defaultMouthpacks/j-"+i.toString());
          ByteData data = await rootBundle.load("assets/images/copyme/"+j.toString()+"-"+i.toString()+".png"); // Do similar for all files
          print("bundled loadade");
          List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
          await File(dir.path+"/"+j.toString()+"-"+i.toString()+".png").writeAsBytes(bytes);
          print("Copied "+j.toString()+"-"+i.toString()+" over.");
        }
      }
    } */
  }

  /* Future<String> get _localPath async{
    final Directory dir = await getApplicationDocumentsDirectory();
    return dir.path;
  } */

  static  Future  requestPermission() async {
    permissionRequest pR = new permissionRequest();
      
    try {
      bool storagePermission = await  pR.requestStoragePermission();
      bool microphonepermission = await pR.requestMicrophonePermission();
      // Add other permissions as needed
      if(microphonepermission && storagePermission)
      {
        print("Permission for microphone and Storage has been granted from main");
      }
      else
      {
        await new Future.delayed(new Duration(seconds : 1));
        print("Full permission not granted in main");
        storagePermission = await  pR.requestStoragePermission();
        microphonepermission = await pR.requestMicrophonePermission();
      }
      await new Future.delayed(new Duration(seconds : 1));
    } catch(err) {
      print ("Permission error"+err);
    }
  }


    
  @override
  void initState() {
    //var  permission=  requestPermission(); 
    super.initState();
    createDir(); 
  }
  
  Widget build(BuildContext context) {
    
    final theme = Provider.of<ThemeChanger>(context);  
    return FutureBuilder<bool>(
      future: getLoggedIn(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          print(snapshot.error);
        }
        if(snapshot.hasData){
          return StreamProvider<User>(
              initialData: User.initial(),
              builder: (context) => locator<AuthenticationService>().userController,
              child: MaterialApp(
                title: 'Mouthpiece',
                theme: theme.getTheme(),
                initialRoute: snapshot.data ? '/' : 'login',
                onGenerateRoute: Router.generateRoute,
             ),
          ); 
        } else {
          return new Center(
            child: new CircularProgressIndicator()
          );
        }    
      },
    );
  }
}

Future<bool> getLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool loggedIn = prefs.getBool('loggedIn');
  // bool loggedIn = false;
  await prefs.setInt('tabIndex', 0);

  
  bool isModeSet = prefs.getKeys().contains('isVolSet');
  if(!isModeSet)
    prefs.setBool('isVolSet', true); 
    // Default Vol
  return loggedIn;
}
