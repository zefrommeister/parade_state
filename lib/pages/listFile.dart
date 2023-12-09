import 'package:parade_state/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:parade_state/pages/home.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:parade_state/pages/loading.dart';
import 'package:parade_state/services/user_sheets_api.dart';

class ListFile extends StatefulWidget {
  const ListFile({Key? key}) : super(key: key);

  @override
  _ListFileState createState() => _ListFileState();
}

class _ListFileState extends State<ListFile> {

  List<String> unit = ['Alpha', 'Bravo', 'Charlie', 'Delta', 'Echo', 'Foxtrot',
    'Golf', 'Hotel', 'India', 'Juliett', 'Kilo', 'Lima', 'Mike', 'November', 'Oscar', 'Papa', 'Quebec', 'Romeo', 'Sierra', 'Tango'];

  List<IconData> icons = [Icons.person, Icons.attach_money_outlined, Icons.computer_sharp, Icons.computer, Icons.computer_outlined, Icons.computer_rounded,
  Icons.all_inbox, Icons.construction_outlined, Icons.construction, Icons.work_outlined, Icons.work_sharp, Icons.work_rounded, Icons.engineering, Icons.note, Icons.masks, Icons.person_pin,
    Icons.masks, Icons.masks, Icons.masks, Icons.masks];

  List<String> password = ["212355", "598953", "465728", "678988", "445768", "184434", "222465", "167433", "811457",
  "867645", "565542", "346978", "114785", "697859", "232574", "945478", "467849", "467849", "467849", "467849"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Choose your unit'),
        centerTitle: true,
        backgroundColor: Colors.grey[400],
        elevation: 0,
      ),
      body: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: unit.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.grey[100],
              child: ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/pass', arguments: {
                    'Unit' : unit[index],
                    'Passcode' : password[index],
                    'selectedUnit' : index,
                  });
                  isSelectedUnit = index;
                },
                leading: Icon(icons[index]),
                title: Text(unit[index]),
              ),
            );
          }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}
