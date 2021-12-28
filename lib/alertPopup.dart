// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AlertPopup extends StatelessWidget {
  final String textButtonText;
  final String titleText;
  final String contentText;
  final String btntext1;
  final String btntext2;
  AlertPopup(this.textButtonText, this.titleText, this.contentText,
      this.btntext1, this.btntext2);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(titleText),
          content: Text(contentText),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: Text(btntext1),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: Text(btntext2),
            ),
          ],
        ),
      ),
      child: Text(textButtonText),
    );
  }
}
