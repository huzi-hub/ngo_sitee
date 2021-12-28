// To parse this JSON data, do
//
//     final donations = donationsFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

List<Donations> donationsFromJson(String str) =>
    List<Donations>.from(json.decode(str).map((x) => Donations.fromJson(x)));

String donationsToJson(List<Donations> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Donations {
  Donations({
    required this.username,
    required this.name,
    required this.quantity,
    required this.date,
    required this.donationId,
  });

  String username;
  String name;
  String quantity;
  DateTime date;
  String donationId;

  factory Donations.fromJson(Map<String, dynamic> json) => Donations(
        username: json["username"],
        name: json["name"],
        quantity: json["quantity"],
        date: DateTime.parse(json["date"]),
        donationId: json["donation_id"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "quantity": quantity,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "donation_id": donationId,
      };
}
