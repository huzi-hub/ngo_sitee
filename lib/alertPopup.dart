// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ngo_site/headingWidget.dart';
import 'package:http/http.dart' as http;

class AlertPopup extends StatefulWidget {
  final ngoId;
  AlertPopup(this.ngoId);

  @override
  State<AlertPopup> createState() => _AlertPopupState();
}

class _AlertPopupState extends State<AlertPopup> {
  final TextEditingController name = TextEditingController();
  final TextEditingController desc = TextEditingController();
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
                      buildTextFormField('Donation Name', name),
                      SizedBox(height: 10),
                      buildTextFormField('Description', desc),
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
                  'Request Donation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  reqDonations();
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

  Future reqDonations() async {
    String url = 'https://edonations.000webhostapp.com/reqdonations.php';
    var data = {
      'title': name.text,
      'description': desc.text,
      'ngo_id': widget.ngoId
    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      Navigator.of(context).pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Can' 't request Donations right now !')));
    }
  }
}
