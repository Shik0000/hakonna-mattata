//log in code with sqflite data base

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/comm/comHelper.dart';
import 'package:flutter_application_1/modules/homepage.dart';
import 'package:flutter_application_1/modules/signupscreen.dart';
import 'package:flutter_application_1/modules/tabs_screen.dart';

import '../comm/genloginSignUpheader.dart';
import '../comm/gentextformfeild.dart';
import '../database/DbHelper.dart';

class loginform extends StatefulWidget {
  @override
  State<loginform> createState() => _loginformState();
}

class _loginformState extends State<loginform> {
  final _formkey = new GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conUserPassword = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
  }

  login() async {
    String uid = _conUserId.text;
    String Password = _conUserPassword.text;

    if (uid.isEmpty) {
      alertDialog(context, 'Please Enter UserName');
    } else if (Password.isEmpty) {
      alertDialog(context, 'Please Enter Password');
    } else {
      await dbHelper.getLoginUser(uid, Password).then((userData) {
        if (userData != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => homepage()),
              (Route<dynamic> route) => false);
        } else {
          alertDialog(context, "Error: USER NOT FOUND");
        }
      }).catchError((error) {
        print(error);
        alertDialog(context, "Error LogiN fail");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login With Sign Up'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                genLoginSignupHeader('LogIn'),
                genTextFormField(
                  controller: _conUserId,
                  icon: Icons.person,
                  hintName: 'User name',
                ),
                SizedBox(
                  height: 5.0,
                ),
                genTextFormField(
                  controller: _conUserPassword,
                  icon: Icons.person,
                  hintName: 'Password',
                  isObscureText: true,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  margin: EdgeInsets.all(1.0),
                  width: double.infinity,
                  child: TextButton(
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: login,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(30)),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Does not have account ?'),
                      TextButton(
                        child: Text(
                          'SignUp',
                          style: TextStyle(color: Colors.pink),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => SignupForm()));
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
    );
  }
}
