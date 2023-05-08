import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter/src/foundation/key.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/comm/comHelper.dart';
import 'package:flutter_application_1/database/DbHelper.dart';

//import 'package:toast/toast.dart';

import '../comm/genloginSignUpheader.dart';
import '../comm/gentextformfeild.dart';
import '../models/Usermodel.dart';
import 'loginscreen.dart';

class SignupForm extends StatefulWidget {
  @override
  //State<SignupForm> createState() => _SignupFormState();
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formkey = new GlobalKey<FormState>();

  final _conUserId = TextEditingController();

  final _conUserName = TextEditingController();
  final _conUserEmail = TextEditingController();
  final _conUserPassword = TextEditingController();
  final _conUserCPassword = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
  }

  signUp() async {
    String uid = _conUserId.text;
    String uName = _conUserName.text;
    String Email = _conUserEmail.text;
    String Password = _conUserPassword.text;
    String CPassword = _conUserCPassword.text;

    if (_formkey.currentState.validate()) {
      if (Password != CPassword) {
        alertDialog(context, 'Password missmatch');
      } else {
        _formkey.currentState.save();

        UserModel uModel = UserModel(uid, uName, Email, Password);
        await dbHelper.saveData(uModel).then((userData) {
          alertDialog(context, "Successfully Saved");

          Navigator.push(
              context, MaterialPageRoute(builder: (_) => loginform()));
        }).catchError((error) {
          print(error);
          alertDialog(context, "Error : Data Save Fail");
        });
      }
      alertDialog(context, "Regestered succesfully");
      print(uid);
      print(uName);
      print(Email);
      print(Password);
      print(CPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('signup screen'),
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  genLoginSignupHeader('SignUp'),
                  genTextFormField(
                    controller: _conUserId,
                    icon: Icons.person,
                    hintName: 'first name',
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  genTextFormField(
                    controller: _conUserName,
                    icon: Icons.person_outline,
                    inputType: TextInputType.name,
                    hintName: 'User name',
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  genTextFormField(
                    controller: _conUserEmail,
                    icon: Icons.email,
                    inputType: TextInputType.emailAddress,
                    hintName: 'email',
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  genTextFormField(
                    controller: _conUserPassword,
                    icon: Icons.password,
                    hintName: 'Password',
                    isObscureText: true,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  genTextFormField(
                    controller: _conUserCPassword,
                    icon: Icons.password,
                    hintName: 'Confirm Password',
                    isObscureText: true,
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child: TextButton(
                      child: Text(
                        'SignUp',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: signUp,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Dear User Once You Creat Accout! please?'),
                        TextButton(
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Colors.pink),
                          ),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => loginform()),
                                (Route<dynamic> route) => false);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
