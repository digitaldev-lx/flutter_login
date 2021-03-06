import 'dart:convert';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loginkit/components/alerts/alert.dart';
import 'package:loginkit/components/rounded_btn/rounded_btn.dart';
import 'package:loginkit/services/login_api.dart';
import 'package:loginkit/services/roles_api.dart';
import 'package:loginkit/ui/login/login.dart';
import 'package:loginkit/ui/success/success.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool showSpinner = false;
  String role;
  String id;
  String name;
  String email;
  String password;
  String confirmPassword;
  List data = []; //edited line

  Future<String> getSWData() async {
    String res = await RolesApi.fetchRoles();
    var resBody = json.decode(res);

    setState(() {
      data = resBody;
    });

    return "true";
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: _goBackButton(context),
          backgroundColor: Color(0xff251F34),
        ),
        backgroundColor: Color(0xff251F34),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Text(
                  'Create Account',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Please fill the input below.',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: (TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400)),
                      keyboardType: TextInputType.name,
                      obscureText: false,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                            color: Colors.white54
                        ),
                        border: InputBorder.none,
                        fillColor: Color(0xfff3B324E),
                        filled: true,
                        prefixIcon: Image.asset('images/icon_user.png'),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff14DAE2), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      onChanged: (value) {
                        name = value;
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: (TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400)),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        labelText: 'E-Mail',
                        labelStyle: TextStyle(
                            color: Colors.white54
                        ),
                        border: InputBorder.none,
                        fillColor: Color(0xfff3B324E),
                        filled: true,
                        prefixIcon: Image.asset('images/icon_email.png'),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff14DAE2), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /*Text(
                      'Register as',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 13,
                          color: Colors.white),
                    ),*/
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                color: Color(0xfff3B324E),
                // width: 100,
                // height: 45,
                child: new DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Register as...',
                    labelStyle: TextStyle(
                        color: Colors.white54
                    ),
                    prefixIcon: Image.asset('images/icon_user.png'),
                  ),
                  style: const TextStyle(color: Colors.white54),
                  dropdownColor: Color(0xfff3B324E),
                  isExpanded: true,
                  hint: new Text(
                    "Choose your position",
                    style: TextStyle(color: Colors.white54),
                  ),
                  value: role,
                  onChanged: (String newValue) {

                    setState(() {
                      role = newValue;
                    });

                    print (role);
                  },
                  items: data.map((map) {
                    return new DropdownMenuItem<String>(
                      value: map["id"].toString(),
                      child: new Text(
                        StringUtils.capitalize(map["name"]),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: (TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400)),
                      obscureText: true,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                            color: Colors.white54
                        ),
                        border: InputBorder.none,
                        fillColor: Color(0xfff3B324E),
                        filled: true,
                        prefixIcon: Image.asset('images/icon_lock.png'),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff14DAE2), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: (TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400)),
                      obscureText: true,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(
                            color: Colors.white54
                        ),
                        border: InputBorder.none,
                        fillColor: Color(0xfff3B324E),
                        filled: true,
                        prefixIcon: Image.asset('images/icon_lock.png'),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xff14DAE2), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      onChanged: (value) {
                        confirmPassword = value;
                      },
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: RoundedButton(
                    btnText: 'SIGN UP',
                    color: Color(0xff14DAE2),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        var user = await LoginApi.register(name, email, password, confirmPassword, role);
                        if (user) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SuccessScreen()));
                        }else{
                          alert(context, "Invalid Credentials!");
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                        color: Colors.grey[600], fontWeight: FontWeight.w400),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text('Sign in',
                        style: TextStyle(
                          color: Color(0xff14DAE2),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _goBackButton(BuildContext context) {
  return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.grey[350]),
      onPressed: () {
        Navigator.of(context).pop(true);
      });
}
