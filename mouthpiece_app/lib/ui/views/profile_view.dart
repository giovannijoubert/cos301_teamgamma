import 'dart:convert';
import 'package:mouthpiece/core/viewmodels/choose_mode_model.dart';
import 'package:mouthpiece/core/viewmodels/collection_model.dart';
import 'package:mouthpiece/ui/shared/theme.dart';
import 'package:mouthpiece/ui/views/choose_mode_view.dart';
import 'package:mouthpiece/ui/views/login_view.dart';
import 'package:mouthpiece/ui/views/register_view.dart';
import 'package:mouthpiece/ui/views/voice_training_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/viewmodels/profile_model.dart';
import '../widgets/bottom_navigation.dart';
import '../../ui/shared/app_colors.dart';
import '../../locator.dart';
import '../../core/services/api.dart';
import 'base_view.dart';
import 'dart:io';
import 'package:flutter/material.dart';
// import '../../core/services/image_picker_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

Api _api = locator<Api>();
SharedPreferences prefs;
bool loggedIn = false;
String image;
String user;
String theme;
String email = "";
String authkey;
String edit = "Edit";
bool editingBool = false;
_ProfileViewState globalParent;
var bytes;
BottomNavigation bottomNavigation = new BottomNavigation();
ChooseModeModel modeModel = new ChooseModeModel();

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with TickerProviderStateMixin {
  // int _currentTabIndex = 2;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  File _image;
  AnimationController _controller;
  // ImagePickerHandler imagePicker;

  GlobalKey<FormState> getForm(){
    return formKey;
  }

  void setter(){
    setState((){ });
  }

  @override
  void initState(){
    super.initState();
    globalParent = this;
    // getLoggedIn();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    // imagePicker = new ImagePickerHandler(this,_controller);
    // imagePicker.init();
  }

  @override
  userImage(File _image) {
    // print(_image);
    setImage(_image);
    setState(() {
      this._image = _image;
    });
  }


  Widget profileSection() {
    return Container (
      margin: EdgeInsets.only(top: 20.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Text(
            user, 
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Helvetica'),
          ),
          text(),
        ],
      )
    );
  }

  Widget textField() {
    return Container(
      child: Text(
        email, 
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, fontFamily: 'Helvetica'),
      )
    );
  }

  Widget textInput() {
    return Container(
      child: Form(
          key: globalParent.getForm(),
          child: Column(
            children: <Widget>[
              BuildEmail(updateState: () {setState(() {});},),
          ],
        )
      )
    );
  }

  Widget text() {
    if(editingBool == false)
      return textField();
    else
      return textInput();
  }

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder<bool>(
        future: getLoggedIn(),
        builder: (context, snapshot){
          if(loggedIn == true){
            return BaseView<ProfileModel>(
              builder: (context, model, child) => Scaffold(
                body: ListView(
                  children: <Widget>[
                    optionSection(globalParent),
                    GestureDetector(
                      onTap: () async {
                        // imagePicker.showDialog(context);
                        // userImage(_image);
                        profileInfo = await chooseImage();
                        this.setter();
                        model.updateProfileImage(base64Encode(profileInfo.readAsBytesSync()));
                      },
                      child: new Center(
                        child: profileInfo == null
                        ? ClipOval(
                          child: Container(
                            child: Image.memory(
                              bytes,
                              height: 100.0,
                              width: 100.0,
                              fit: BoxFit.contain,
                            ),
                            decoration: BoxDecoration(color: Colors.white),
                          ),
                        )
                        : ClipOval(
                          child: Container(
                            child: Image.file(
                              profileInfo,
                              height: 100.0,
                              width: 100.0,
                              fit: BoxFit.contain,
                            ),
                            decoration: BoxDecoration(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    profileSection(),
                    PreferencesSection(),
                    SignOutButton(),
                  ]
                ),
                bottomNavigationBar: BottomNavigation(),
              ),
            );
          } 
           else if(loggedIn == false){
            return BaseView<ProfileModel>(
              builder: (context, model, child) => Scaffold(
                // backgroundColor: backgroundColor,
                body: ListView(
                  children: <Widget>[
                    profileSection2,
                    PreferencesSection2(),
                    SignOutButton2(),
                  ],
                ),
                bottomNavigationBar: BottomNavigation(),
              ),
            );
          }
        },
    );
  }
}

Widget optionSection (_ProfileViewState parent){
    return Container (
      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
      child: RawMaterialButton(
        onPressed: () async{
          if(editingBool == false){
              edit = "Save";
              editingBool = true;
          }else{
            final form = globalParent.getForm().currentState;
            if(form.validate()){
              form.save();
              edit = "Edit";
              editingBool = false;
            }
          }
          parent.setter();
        },
        child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              // Icon(Icons.arrow_back_ios),
              new Text(
                edit, 
                // textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, fontFamily: 'Helvetica'),
              ),
            ]
          ),
      ),
    );
}


Widget divider = new Container(
  child: Divider(thickness: 1.2,),
  margin: EdgeInsets.only(top: 5, bottom: 12),
);

Widget dividerGrey = new Container(
  child: Divider(color: Colors.grey, thickness: 1.2,),
  margin: EdgeInsets.only(top: 5, bottom: 12),
);

Widget profileSection2 = new Container (
  margin: EdgeInsets.only(top: 20.0),
  child: new Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      SizedBox(height: 40),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0),
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Container(
          child: new Icon(Icons.person, size: 90, color: Color(0xFF303030)), 
          width: 100,
          height: 100,
        ),
      ),
      SizedBox(height: 10),
      new Text(
        "Anonymous", 
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Helvetica'),
      ),
      new Text(
        "", 
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, fontFamily: 'Helvetica'),
      )
    ],
  )
);

class PreferencesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    ThemeData _theme = _themeChanger.getTheme();
    return new Container (
      margin: EdgeInsets.only(left: 20, right: 20, top: 40),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(context, PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => ChooseModeView(),
              ),);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Row(
                  children: <Widget> [
                    Padding(child: new Icon(Icons.mic), padding: EdgeInsets.only(right: 10),),
                    new Text(
                    'Choose Listening Mode', 
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontFamily: 'Helvetica')),
                  ]
                ),
                new Icon(Icons.arrow_forward_ios),
              ],
            ), 
          ),
          divider,
          InkWell(
            onTap: () async {
              if (_theme == darkTheme){
                _themeChanger.setTheme(lightTheme);
                setTheme('Light');
              } else {
                _themeChanger.setTheme(darkTheme);
                setTheme('Dark');
                }
              },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Row(
                  children: <Widget> [
                    Padding(child: new Icon(Icons.brightness_4), padding: EdgeInsets.only(right: 10)),
                    new Text(
                    (_theme == darkTheme) ? "Light Mode" : "Dark Mode", 
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontFamily: 'Helvetica')),
                  ]
                ),
                new Icon(Icons.hdr_weak),
              ],
            ),
          ),
          divider,
          InkWell(
            onTap: () {
              Navigator.push(context, PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => VoiceTrainingView(),
              ),);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Row(
                  children: <Widget> [
                    Padding(child: new Icon(Icons.settings_voice), padding: EdgeInsets.only(right: 10)),
                    new Text(
                    'Voice Training', 
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontFamily: 'Helvetica')),
                  ]
                ),
                new Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          divider
        ],
      ),
    );
  }
}

class PreferencesSection2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    ThemeData _theme = _themeChanger.getTheme();
    return new Container (
      margin: EdgeInsets.only(left: 20, right: 20, top: 40),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(context, PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => ChooseModeView(),
              ),);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Row(
                  children: <Widget> [
                    Padding(child: new Icon(Icons.mic), padding: EdgeInsets.only(right: 10),),
                    new Text(
                    'Choose Listening Mode', 
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontFamily: 'Helvetica')),
                  ]
                ),
                new Icon(Icons.arrow_forward_ios),
              ],
            ), 
          ),
          divider,
          InkWell(
            onTap: () async {
              if (_theme == darkTheme){
                _themeChanger.setTheme(lightTheme);
                setTheme('Light');
              } else {
                _themeChanger.setTheme(darkTheme);
                setTheme('Dark');
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Row(
                  children: <Widget> [
                    Padding(child: new Icon(Icons.brightness_4), padding: EdgeInsets.only(right: 10)),
                    new Text(
                    (_theme == darkTheme) ? "Light Mode" : "Dark Mode", 
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontFamily: 'Helvetica')),
                  ]
                ),
                new Icon(Icons.hdr_weak),
              ],
            ),
          ),
          divider,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Row(
                children: <Widget> [
                  Padding(child: new Icon(Icons.settings_voice, color: Colors.grey), padding: EdgeInsets.only(right: 10)),
                  new Text(
                  'Voice Training', 
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, fontFamily: 'Helvetica', color: Colors.grey)),
                ]
              ),
              new Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
          dividerGrey
        ],
      ),
    );
  }
}


class SignOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _theme = Provider.of<ThemeChanger>(context);
    return new Container (
      width: 20,
      height: 50,
      margin: EdgeInsets.only(top: 20, bottom: 10),
      padding: EdgeInsets.fromLTRB(95, 0, 95, 0),
      child: RaisedButton(
        onPressed: () async {
          CollectionModel collectionModel = new CollectionModel();
          prefs = await SharedPreferences.getInstance();
          await prefs.remove('isVolSet');
          await prefs.remove('username');
          await prefs.remove('email');
          await prefs.remove('pass');
          await prefs.remove('profile_image');
          await prefs.remove('userInfo');
          prefs.remove('jwt');
          bottomNavigation.setIndex(0);
          await prefs.setInt('tabIndex', 0);
          await prefs.setBool('loggedIn', false);
          await prefs.setBool('navVal', false);
          await prefs.setString("theme", "Light");
          await _theme.setTheme(lightTheme);
          await collectionModel.clearLists();
          modeModel.clearMode();
          Navigator.of(context).pushAndRemoveUntil(PageRouteBuilder(pageBuilder: (context, animation1, animation2) => LoginView()), (Route<dynamic> route) => false);
        },
        // padding: EdgeInsets.all(15),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        // color: Color(0xFF303030),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget> [
            Padding(child: Icon(Icons.exit_to_app, color: (_theme.getTheme() == lightTheme) ? Colors.white : Colors.black,), padding: EdgeInsets.only(right: 5),),
            Text('Sign Out', style: TextStyle(fontFamily: 'Helvetica', fontSize: 15, fontWeight: FontWeight.w500),),
          ],
        )
      ),
    );
  }
}

class SignOutButton2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeChanger>(context);
    return new Container (
      width: 20,
      height: 50,
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.fromLTRB(95, 0, 95, 0),
      child: RaisedButton(
        onPressed: () async {
          prefs = await SharedPreferences.getInstance();
          bottomNavigation.setIndex(0);
          await prefs.setInt('tabIndex', 0);
          await prefs.setBool('navVal', false);
          await prefs.setString("theme", "Light");
          await _theme.setTheme(lightTheme);
          prefs.remove('isVolSet');
          modeModel.clearMode();
          Navigator.of(context).pushAndRemoveUntil(PageRouteBuilder(pageBuilder: (context, animation1, animation2) => RegisterView()), (Route<dynamic> route) => false);
        },
        // padding: EdgeInsets.all(15),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        // fillColor: Color(0xFF303030),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget> [
            Padding(child: Icon(Icons.exit_to_app, color: (_theme.getTheme() == lightTheme) ? Colors.white : Colors.black,), padding: EdgeInsets.only(right: 5),),
            Text('Register', style: TextStyle(fontFamily: 'Helvetica', fontSize: 15, fontWeight: FontWeight.w500),),
          ],
        )
      ),
    );
  }
}

Future setEmail(String mail) async{
  prefs = await SharedPreferences.getInstance();
  prefs.setString('email', mail); 
}

Future setTheme(String theme) async{
    prefs = await SharedPreferences.getInstance();
    Map map = {
      "option": "theme",
      "username" : user,
      "jwt" : authkey,
      "theme" : theme  
    };
    String url = 'https://teamgamma.ga/api/umtg/update';
    _api.updateTheme(url, map);
    prefs.setString('theme', theme);
}

Future setImage(File _image) async{
  prefs = await SharedPreferences.getInstance();
  String base =  base64Encode(_image.readAsBytesSync());
  prefs.setString('profile_image',base);
  Map map = {
    "option": "image",
    "username" : user,
    "jwt" : authkey,
    "image" : base
  };
  String url = 'https://teamgamma.ga/api/umtg/update';
  _api.updateImage(url,map);
}

class BuildEmail extends StatefulWidget {
  final Function() updateState;
  BuildEmail({Key key, @required this.updateState}) : super(key: key);

  @override
  _BuildEmailState createState() => _BuildEmailState();
}

class _BuildEmailState extends State<BuildEmail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Email', 
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(), 
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
            )
          ),
          focusColor: Colors.blue
        ),
        initialValue: email,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Email is required';
          }
          if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value)) {
            return 'Please enter a valid email address';
          }
        },
        onChanged: (value) {
          setState(() {
            email = value;
            setEmail(value);
            widget.updateState();
          });
        },
        onSaved: (String value) async {
          Map map = {
            "option" : "altmail",
            "username" : user,
            "jwt" : authkey,
            "email" : value
          };
          String url = 'https://teamgamma.ga/api/umtg/update';
          await _api.updateMail(url, map).then((response) {
              if (response == false) {
                Fluttertoast.showToast(
                  msg: "The email you've entered already exists ",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.white60,
                  textColor: Colors.black,
                  fontSize: 16.0
                );
              } else {
                email = value;
                setEmail(value);
              }
          });
        },
      ),
    );
  }
}

Future<bool> getLoggedIn() async {
  prefs = await SharedPreferences.getInstance();
  loggedIn = prefs.getBool('loggedIn') ?? false;

  if (loggedIn) {
    user =  prefs.getString('username');
    email =  prefs.getString('email');
    authkey =  prefs.getString('jwt');
    image = prefs.getString("profile_image");
    bytes = base64Decode(image);

  } else {
    image = "";
    email = "";
    user = "";
    theme = "";
    authkey = "";
  }
  bool vari =  prefs.getBool('loggedIn') ?? true;
  return vari;
}

File profileInfo;

Future chooseImage() async {
  var file = await ImagePicker.pickImage(source: ImageSource.gallery);
  return file;
// file = await ImagePicker.pickImage(source: ImageSource.gallery);
}