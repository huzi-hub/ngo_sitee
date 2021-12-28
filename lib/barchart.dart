// import 'package:chartapp/network/network_helper.dart';
// import 'package:chartapp/src/Bar_Chart/bar_model.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/donationsModel.dart';
import 'package:http/http.dart' as http;

class BarChartAPI extends StatefulWidget {
  int ngoId;
  BarChartAPI(this.ngoId);

  @override
  State<BarChartAPI> createState() => _BarChartAPIState();
}

var _tooltipBehavior;

class _BarChartAPIState extends State<BarChartAPI> {
  List<Donations> genders = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getData();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  void getData() async {
    const String url =
        'https://edonations.000webhostapp.com/ngo-donationhistory.php';
    var data = {'ngo_id': widget.ngoId};

    var result = await http.post(Uri.parse(url), body: jsonEncode(data));

    List<Donations> tempdata = donationsFromJson(result.body);
    setState(() {
      genders = tempdata;
      loading = false;
    });
  }

  _createSampleData() {
    return SfCartesianChart(
        // Enables the tooltip for all the series in chart
        tooltipBehavior: _tooltipBehavior,
        // Initialize category axis
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
          // Initialize line series

          LineSeries<Donations, String>(
              // Enables the tooltip for individual series
              enableTooltip: true,
              dataSource: genders,
              xValueMapper: (Donations sales, _) => sales.date.toString(),
              yValueMapper: (Donations sales, _) =>
                  double.parse(sales.quantity))
        ]);
    // [
    //   charts.Series<Donations, String>(
    //     data: genders,
    //     id: 'sales',
    //     colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
    //     domainFn: (Donations genderModel, _) => genderModel.name,
    //     measureFn: (Donations genderModel, _) =>
    //         int.parse(genderModel.quantity),
    //   )
    // ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: loading
            ? CircularProgressIndicator()
            : Container(
                height: 300,
                child: _createSampleData(),
              ),
      ),
    );
  }
}
