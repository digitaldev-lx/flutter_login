import 'package:flutter/material.dart';

void alert(BuildContext context, String msg) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // retorna um objeto do tipo Dialog
      return AlertDialog(
        title: new Text("Login"),
        content: new Text(msg),
        actions: <Widget>[
          // define os botões na base do dialogo
          new TextButton(
            child: new Text("OK"),
            onPressed: () {
              // Navigator.of(context).pop();
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}