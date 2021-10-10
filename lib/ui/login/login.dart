import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loginkit/components/rounded_btn/rounded_btn.dart';
import 'package:loginkit/services/login_api.dart';
import 'package:loginkit/ui/create_account/create_account.dart';
import 'package:loginkit/ui/success/success.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool showSpinner = false;

  String email;
  String password;
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  /*final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();*/

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: SafeArea(
        child: Scaffold(
          // resizeToAvoidBottomPadding: true,
          backgroundColor: Color(0xff251F34),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: SizedBox(
                        width: 175,
                        height: 175,
                        child: Image.asset('images/logo.png'),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 8),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /*Text(
                          'E-mail',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                              color: Colors.white),
                        ),*/
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: _emailController,
                          style: (TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.white,
                          obscureText: false,
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
                              borderSide: BorderSide(
                                  color: Color(0xff14DAE2), width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                          ),
                          onChanged: (value) {
                            email = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /*Text(
                        'Password',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 13,
                            color: Colors.white),
                      ),*/
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _passwordController,
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
                            borderSide: BorderSide(
                                color: Color(0xff14DAE2), width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: RoundedButton(
                      btnText: 'LOGIN',
                      color: Color(0xff14DAE2),
                      onPressed: () async {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        setState(() {
                          showSpinner = true;
                        });
                        try {
                          var user = await LoginApi.login(email, password);
                          if (user) {
                            if(!currentFocus.hasPrimaryFocus){
                              currentFocus.unfocus();
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SuccessScreen()));
                          } else {
                            _passwordController.clear();

                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                Center(
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Color(0xff14DAE2)),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont have an account?',
                      style: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateAccount()));
                      },
                      child: Text('Sign up',
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
      ),
    );
  }

  final snackBar = SnackBar(content: Text(
    'Invalid Credentials!', textAlign: TextAlign.center
  ), backgroundColor: Colors.redAccent);

}
