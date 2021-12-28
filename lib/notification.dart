import 'dart:convert';
import 'Ngo_Home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  final currentPassword;
  final email;
  final storage;
  final ngo_Id;
  ChangePassword(this.currentPassword, this.email, this.storage, this.ngo_Id);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

TextEditingController currentpassword = TextEditingController();
TextEditingController newPass = TextEditingController();

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Change Password'),
          backgroundColor: Colors.cyan,
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.only(top: 30),
            width: 300,
            child: Column(
              children: [
                TextFormField(
                  controller: currentpassword,
                  decoration: InputDecoration(
                    hintText: "Current Password",
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: newPass,
                  decoration: InputDecoration(hintText: "New Password"),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration:
                      InputDecoration(hintText: " Re enter New Password"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: RaisedButton(
                    child: Text("Update"),
                    onPressed: () {
                      changePass();
                    },
                  ),
                ),
                Text(widget.email),
              ],
            ),
          ),
        ));
  }

  Future changePass() async {
    String url = 'https://edonations.000webhostapp.com/api-changePassword.php';
    var data = {'email': widget.email, 'password': newPass.text};
    //var msg = jsonDecode(result.body);
    if (widget.currentPassword == currentpassword.text) {
      var result = await http.post(Uri.parse(url), body: jsonEncode(data));
      if (result.statusCode == 200) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Ngo_Home(widget.storage, widget.ngo_Id)));
      } else {
        SnackBar(content: Text('Please Enter Correct Current Password'));
      }
    }
  }
}
