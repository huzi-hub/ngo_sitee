// ignore_for_file: file_names, unnecessary_string_interpolations, must_be_immutable

import 'package:flutter/material.dart';
import './donationHistory.dart';
import './headingWidget.dart';
import 'Services/donationServices.dart';

class WarehouseStorage extends StatelessWidget {
  //List<DonationData> donations;
  final storage;
  WarehouseStorage(this.storage);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          HeadingWidget('Warehouse Storage'),
          Container(
            height: 150,
            color: Colors.white,
            child: Center(
              child: Text(
                'Available Storage\n $storage kg',
                textAlign: TextAlign.center,
                style: const TextStyle(fontFamily: 'Quicksand', fontSize: 32),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Storage Details',
            style: TextStyle(fontFamily: 'Quicksand', fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 400,
            // child: ListView.builder(
            //     itemCount: donations.length,
            //     itemBuilder: (context, index) {
            //       return Card(
            //         margin:
            //             const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            //         elevation: 1.0,
            //         child: ListTile(
            //           leading: Text('${(index + 1).toString()}',
            //               style: const TextStyle(
            //                 fontFamily: 'Quicksand',
            //                 fontSize: 20,
            //               )),
            //           title: Text(
            //             donations[index].donationName,
            //             style: const TextStyle(
            //               fontFamily: 'Quicksand',
            //               fontSize: 20,
            //             ),
            //           ),
            //           subtitle: Text('${donations[index].day}'),
            //           trailing: Column(children: [
            //             const Text('Amount'),
            //             Text('${donations[index].donationAmount}')
            //           ]),
            //         ),
            //       );
            //     }),
          ),
        ],
      ),
    );
  }
}
