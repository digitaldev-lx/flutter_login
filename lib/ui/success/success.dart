import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:confetti/confetti.dart';
import 'package:loginkit/components/rounded_btn/rounded_btn.dart';
import 'package:loginkit/services/login_api.dart';
import 'package:loginkit/ui/login/login.dart';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class SuccessScreen extends StatefulWidget {
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  ConfettiController _controllerBottomCenter;

  @override
  void initState() {

    ConfettiController(duration: const Duration(seconds: 5));
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _controllerBottomCenter.play());
    super.initState();

  }

  @override
  void dispose() {
    _controllerBottomCenter.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff251F34),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controllerBottomCenter,
              blastDirection: pi / 2,
              maxBlastForce: 3, // set a lower max blast force
              minBlastForce: 2,
              emissionFrequency: 0.3,
              minimumSize: const Size(10,
                  10), // set the minimum potential size for the confetti (width, height)
              maximumSize: const Size(20,
                  20), // set the maximum potential size for the confetti (width, height)
              numberOfParticles: 1,
              gravity: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('Congratulations,',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 27
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('You have logged in.',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 23
              ),
            ),
          ),
          SizedBox(
              height: 200,
              width: 200,
              child: Image.asset('images/celebration.png')),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: RoundedButton(
                btnText: 'LOGOUT',
                color: Colors.redAccent,
                onPressed: () async {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  try {
                    var status = await LoginApi.logout();
                    if (status) {
                      if(!currentFocus.hasPrimaryFocus){
                        currentFocus.unfocus();
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Login()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }

                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ),
          ),
        ],

      ),
    );
  }

  final snackBar = SnackBar(content: Text(
      'Impossible logout! Try it later.!', textAlign: TextAlign.center
  ), backgroundColor: Colors.redAccent);
}