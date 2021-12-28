// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, unnecessary_string_interpolations, sized_box_for_whitespace, camel_case_types

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../Login.dart';

class Volunteer_Registration extends StatefulWidget {
  @override
  State<Volunteer_Registration> createState() => _Volunteer_Registration();
}

class _Volunteer_Registration extends State<Volunteer_Registration> {
  String? value;
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController cell = TextEditingController();
  late int ngo_id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
              height: 200,
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Volunteer Registration',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      height: 130,
                      width: 230,
                      child: Image(
                        image: AssetImage(
                          'assets/1.png',
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Container(
                height: 370,
                width: 300,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildTextFormField('Volunteer Name', name),
                      SizedBox(height: 10),
                      buildTextFormField('Email', email),
                      SizedBox(height: 10),
                      buildTextFormField('password', password),
                      SizedBox(height: 10),
                      buildTextFormField('Address', address),
                      SizedBox(height: 10),
                      buildTextFormField('contact', cell),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.blueGrey,
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  register();
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already Have Acccount?'),
                InkWell(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Color(0xff8CA1A5),
                      fontSize: 15,
                    ),
                  ),
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => SignUp()));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  TextFormField buildTextFormField(
      hintname, TextEditingController textController) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
          fillColor: Color(0xff8CA1A5),
          filled: true,
          hintText: hintname,
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          )),
    );
  }

  Future register() async {
    String url = 'https://edonations.000webhostapp.com/api-volunteer-reg.php';
    var data = {
      'username': name.text,
      'email': email.text,
      'password': password.text,
      'address': address.text,
      'contact': cell.text,
      'ngo_id': ngo_id
    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      if (msg == 'registered successfully') {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Login()));
      }
    } else {
      SnackBar(content: Text('Not Registered!'));
    }
  }
}
