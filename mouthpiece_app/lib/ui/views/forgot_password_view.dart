import 'package:connectivity/connectivity.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mouthpiece/core/services/sharing_api.dart';
import 'package:mouthpiece/core/viewmodels/collection_model.dart';
import 'package:mouthpiece/core/viewmodels/forgot_password_model.dart';
import 'package:mouthpiece/locator.dart';
import 'package:mouthpiece/ui/shared/theme.dart';
import 'package:mouthpiece/ui/views/choose_mode_view.dart';
import 'package:mouthpiece/ui/views/home_view.dart';
import 'package:mouthpiece/ui/views/login_view.dart';
import 'package:mouthpiece/ui/views/register_view.dart';
import 'package:mouthpiece/ui/views/voice_training_view.dart';
import 'package:provider/provider.dart';
import '../../core/enums/viewstate.dart';
import '../../core/viewmodels/login_model.dart';
import '../../ui/shared/app_colors.dart';
import '../../ui/shared/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'base_view.dart';
import '../../core/services/sharing_api.dart';
 
class ForgotPasswordView extends StatefulWidget {
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}
 
class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SharingApi _sharingapi = locator<SharingApi>();

  String _email;
  bool circularDisplay = false;

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      // maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          setState(() {
            circularDisplay = false;
          });
          return 'Email is required';
        }
        if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value)) {
          setState(() {
            circularDisplay = false;
          });
          return 'Please enter a valid email address';
        }

        return null;
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  var subscription;

  @override
  initState() {
    super.initState();

    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print("connectivity: $result");
      if (result == ConnectivityResult.none) {
        Fluttertoast.showToast(
          msg: "Please check your internet connectivity",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Color(0xff303030),
          textColor: Colors.white,
          fontSize: 16.0
        );
      } 
    });
  }

  // Be sure to cancel subscription after you are done
  @override
  dispose() {
    super.dispose();

    subscription.cancel();
  }

  Future _sendEmailCommand(model, theme) async{
    bool connectivity = await _sharingapi.checkConnectivity();
    if (connectivity) {
      var emailExists = await model.checkForEmail(_email);
      if(emailExists) {
        await model.resetPasswordNotification(_email);
        Fluttertoast.showToast(
          msg: "Email sent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Color(0xff303030),
          textColor: Colors.white,
          fontSize: 16.0
        );
        setState(() {
          circularDisplay = false;
        });
      } else {
        setState(() {
          circularDisplay = false;
        });

        Fluttertoast.showToast(
          msg: "There is no user registered with this email.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Color(0xff303030),
          textColor: Colors.white,
          fontSize: 16.0
        );
      }
    } else {
      setState(() {
        circularDisplay = false;
      });

      Fluttertoast.showToast(
        msg: "Please check your internet connectivity",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color(0xff303030),
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }

  @override
   Widget build(BuildContext context) {
    // precacheImage(AssetImage("assets/images/wave.png"), context);
    final theme = Provider.of<ThemeChanger>(context);  
    return BaseView<ForgotPasswordModel>(
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              LoginHeader(),
              Container(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget> [ 
                      _buildName(),
                    ],
                  ),
                ),
              ),
              Visibility(
                child: Center(child: Container(margin: EdgeInsets.only(top: 5), child: CircularProgressIndicator())),
                visible: circularDisplay,
                 
              ),
              Visibility(
                visible: !circularDisplay,
                child: Container(
                  height: 50,
                  width: 325,
                  margin: const EdgeInsets.only(top: 20.0),
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: mainTextColor,
                      child: Text(
                      'Send email',
                      style: TextStyle(fontSize: 15,
                      fontFamily: 'Arciform'),
                    ),
                    onPressed: () async {
                      setState(() {
                        circularDisplay = true;
                      });
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }

                      final form = formKey.currentState;

                      if (form.validate()) {
                        form.save();
                        await _sendEmailCommand(model, theme);
                      }
                    },
                      shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    )
                  )
                ),
              ),
              BackLink(),  
            ],
          ),
        ),
      ),
    );
  }
}

class LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
      padding: EdgeInsets.all(10),
      child: Text(
        'Enter your email address',
        style: TextStyle(fontSize: 20,
        color: Color(0xff303030),
        fontFamily: 'Arciform'),
      )
    );
  }
}


class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;
  final bool obscureText;

  TextInputField(this.controller, this.label, this.hintText, this.obscureText);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
          style: new TextStyle(color: Color(0xff303030)),
          obscureText: obscureText,
          decoration: new InputDecoration(
            hintText: hintText,
            hintStyle: hintStyle,
            labelText: label,
            labelStyle: inputFieldStyle,
            /* enabledBorder: UnderlineInputBorder(      
              borderSide: BorderSide(color: Colors.cyan),   
            ), */  
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff303030)),
            ),  
          ),
          controller: controller,
      ),
    );
  }
}

class BackLink extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.only(top: 2),
              child: Text(
                'Back',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xffB1B4E5),
                  fontFamily: 'Helvetica',
                  decoration: TextDecoration.underline,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
          mainAxisAlignment: MainAxisAlignment.start,
        )
      )
    );
  }
}



