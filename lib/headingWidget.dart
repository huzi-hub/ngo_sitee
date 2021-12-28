// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

class HeadingWidget extends StatefulWidget {
  final String heading;
  HeadingWidget(this.heading);

  @override
  State<HeadingWidget> createState() => _HeadingWidgetState();
}

class _HeadingWidgetState extends State<HeadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Card(
        elevation: 0.0,
        child: Row(
          children: [
            Container(
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.green,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.05,
              color: Colors.white,
              child: Text(
                widget.heading,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
