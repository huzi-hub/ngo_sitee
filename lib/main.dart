import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ngo_site/Ngo_Home.dart';
import 'package:ngo_site/volunteer_reg.dart';

import 'Login.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
