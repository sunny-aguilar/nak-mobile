import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ShowDialogToDismiss extends StatelessWidget {
  const ShowDialogToDismiss({
    super.key,
    required this.content,
    required this.title,
    required this.buttonText
  });

  final String content;
  final String title;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () { Navigator.of(context).pop(); },
            child: Text(buttonText),
          ),
        ],
      );
    }
    else {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () { Navigator.of(context).pop(); },
            child: Text(
              buttonText[0].toUpperCase() + buttonText.substring(1).toLowerCase(),
            ),
          ),
        ],
      );
    }
  }
}