import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ParadeStateFields {

  static String rank = "RANK";
  static String name = "NAME";
  static String date = "DATE";
  static String morningState = "AM";
  static String afternoonState = "PM";

  ParadeStateFields({rank, name, date, morningState, afternoonState});

  static List<String> getPS() => [rank, name, date, morningState, afternoonState];


}

class ParadeState{
  final String rank;
  final String name;
  final String date;
  final String morningState;
  final String afternoonState;

  const ParadeState ({
    required this.rank,
    required this.name,
    required this.date,
    required this.morningState,
    required this.afternoonState,
  });

  Map<String, dynamic> toJson() => {
    ParadeStateFields.rank: rank,
    ParadeStateFields.name: name,
    ParadeStateFields.date: date,
    ParadeStateFields.morningState: morningState,
    ParadeStateFields.afternoonState: afternoonState,
  };

}


