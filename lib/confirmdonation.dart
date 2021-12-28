// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, unnecessary_string_interpolations, sized_box_for_whitespace, prefer_const_constructors_in_immutables, unnecessary_new

import 'dart:convert';
import 'package:flutter/material.dart';
import './headingWidget.dart';
import 'package:http/http.dart' as http;

import 'models/ngoDonations.dart';

// ignore: must_be_immutable
class AcceptDonation extends StatefulWidget {
  final ngoId;
  AcceptDonation(this.ngoId);
  @override
  _AcceptDonationState createState() => _AcceptDonationState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _AcceptDonationState extends State<AcceptDonation> {
  String? _mySelection;

  List volunteers = [];

  Future<String> getSWData() async {
    String url = 'https://edonations.000webhostapp.com/drop-down.php';
    var data = {'ngo_id': widget.ngoId};
    var res = await http.post(Uri.parse(url),
        body: jsonEncode(data), headers: {'Accept': "application/json"});

    var resBody = json.decode(res.body);

    setState(() {
      volunteers = resBody;
    });

    print(resBody);

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: [
          HeadingWidget('Accept Donations'),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: const Text(
              'Pending Donations',
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.79,
            margin: const EdgeInsets.only(top: 10),
            child: FutureBuilder<List<NgoDonations>>(
              future: fetchDonations(http.Client()),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error has occurred!'),
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Card(
                              margin: EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal:
                                      MediaQuery.of(context).size.height *
                                          0.01),
                              elevation: 1.0,
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 30,
                                  child: Expanded(
                                      child:
                                          Text(snapshot.data![index].username)),
                                ),
                                title: Text(
                                  snapshot.data![index].name,
                                  style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 20,
                                  ),
                                ),
                                subtitle: Text('${snapshot.data![index].date}'),
                                trailing: Column(children: [
                                  Text('Quantity'),
                                  Text(snapshot.data![index].quantity),
                                ]),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  child: volunteerList(),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red),
                                    onPressed: () {
                                      delDonation(int.parse(
                                          snapshot.data![index].donation_id));
                                      setState(() {});
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.done_outlined),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01),
                                        Text(
                                          'Reject',
                                          style: TextStyle(
                                              fontFamily: 'Quicksand',
                                              fontSize: 16),
                                        )
                                      ],
                                    )),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green),
                                    onPressed: () {
                                      if (_mySelection != 'volunteer') {
                                        accpetDonation(
                                            int.parse(snapshot
                                                .data![index].donation_id),
                                            int.parse(snapshot
                                                .data![index].quantity));
                                        setState(() {});
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Please Assign Volunteer')));
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.done_outlined),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01),
                                        Text(
                                          'Accept',
                                          style: TextStyle(
                                              fontFamily: 'Quicksand',
                                              fontSize: 16),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                          ],
                        );
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  int? vol_id;
  Widget volunteerList() {
    return DropdownButton<String>(
      hint: Text('Select volunteer'),
      items: volunteers.map((item) {
        vol_id = int.parse(item['volunteer_id']);
        return new DropdownMenuItem(
          child: new Text(
            item['volunteername'],
          ),
          value: item['volunteer_id'].toString(),
        );
      }).toList(),
      onChanged: (val) {
        setState(() {
          _mySelection = val.toString();
        });
      },
      value: _mySelection,
    );
  }

  Future<List<NgoDonations>> fetchDonations(http.Client client) async {
    const String url =
        'https://edonations.000webhostapp.com/api-pendingdonations.php';
    var data = {'ngo_id': widget.ngoId};

    var result = await http.post(Uri.parse(url), body: jsonEncode(data));

    if (result.statusCode == 200) {
      final parsed = json.decode(result.body).cast<Map<String, dynamic>>();
      return parsed
          .map<NgoDonations>((json) => NgoDonations.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future accpetDonation(final donationId, int quantity) async {
    String url = 'https://edonations.000webhostapp.com/api-acceptdonation.php';
    var data = {
      'donation_id': donationId,
      'volunteer_id': vol_id,
      'quantity': quantity,
      'ngo_id': widget.ngoId
    };

    if (_mySelection != null) {
      var result = await http.post(Uri.parse(url), body: jsonEncode(data));
      var msg = jsonDecode(result.body);
      if (result.statusCode == 200) {
        final snackBar = SnackBar(content: Text('Confirmed'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Not Confirmed')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('please Assign Volunteer')));
    }
  }

  Future delDonation(final donationId) async {
    String url = 'https://edonations.000webhostapp.com/api-deleteDonation.php';
    var data = {'donation_id': donationId};
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Deleted!'),
      ));
    } else {
      SnackBar(content: Text('Not deleted'));
    }
  }
}
