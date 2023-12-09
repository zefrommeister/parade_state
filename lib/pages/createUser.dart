import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';
import 'package:parade_state/main.dart';
import 'package:flutter/material.dart';
import 'package:parade_state/services/parade_state.dart';
import 'package:parade_state/pages/loading.dart';
import 'package:parade_state/services/user_sheets_api.dart';
import 'package:parade_state/pages/listFile.dart';
import 'package:parade_state/services/database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parade_state/pages/completion.dart';

class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {

  String dropdownRankValue = 'PTE';
  Map data = {};
  String formatted = '';
  TextEditingController nameController = TextEditingController();
  int selectedValue = 0;
  bool value = false;

  List<String> ranks = <String>[
    'REC',
    'PTE',
    'LCP',
    'CPL',
    'CFC',
    'SCT',
    '3SG',
    '2SG',
    '1SG',
    'SSG',
    'MSG',
    '3WO',
    '2WO',
    '1WO',
    '2LT',
    'LTA',
    'CPT',
    'MAJ',
    'DXO',
    'ME2',
    'ME3',
    'ME4'
  ];


  List<String> psUnit = ['Alpha', 'Bravo', 'Charlie', 'Delta', 'Echo', 'Foxtrot',
    'Golf', 'Hotel', 'India', 'Juliett', 'Kilo', 'Lima', 'Mike', 'November', 'Oscar', 'Papa', 'Quebec', 'Romeo', 'Sierra', 'Tango'];

  List<String> fbUnit = ['alphapstate', 'bravopstate', 'charliepstate', 'deltapstate', 'echopstate', 'foxtrotpstate',
    'golfpstate', 'hotelpstate', 'indiapstate', 'juliettpstate', 'kilopstate', 'limapstate', 'mikepstate', 'novemberpstate', 'oscarpstate', 'papapstate', 'quebecpstate', 'romeopstate', 'sierrapstate', 'tangopstate'];

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    formatted = data['DateTime'];

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(psUnit[isSelectedUnit] + ' PARADE STATE'),
          centerTitle: true,
          backgroundColor: Colors.blue[600],
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            onPressed: () {
                Navigator.pushReplacementNamed(context, '/completion', arguments: {
                'DateTime' : formatted,
                'selectedUnit' : isSelectedUnit,
                });
              },
          ),
        ),

        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.lightBlue,
                Colors.cyan,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/bearbear-removebg-preview.png'),
                      radius: 50.0,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Divider(
                    height: 70.0,
                    color: Colors.grey[800],
                  ),

                  SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        shadowColor: Colors.amber,
                        elevation: 12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(12.0),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'RANK: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                              DropdownButton<String>(
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownRankValue = newValue!;
                                  });
                                },
                                value: dropdownRankValue,
                                style: TextStyle(
                                  color: Colors.blue[400],
                                ),
                                items: ranks.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'NAME: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 8.0),
                              TextField(
                                style: TextStyle(color: Colors.grey[700]),
                                controller: nameController,
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]"))],
                                decoration: InputDecoration(
                                  hintText: "Name",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              CheckboxListTile(
                                  value: value,
                                  controlAffinity: ListTileControlAffinity.leading,
                                  title: Text("Is he/she a regular?"),
                                  onChanged: (value) {
                                    setState(() {
                                      this.value = value!;
                                    });
                                  }
                              ),
                              SizedBox(height: 8.0),
                              Center(
                                child: RaisedButton.icon(
                                  onPressed: (){
                                    final name = nameController.text;
                                    final rank = dropdownRankValue;
                                    final reg = value;

                                    createUser(rank: rank, name: name, reg: reg);

                                    setState(() {
                                      Navigator.pushReplacementNamed(context, '/completion', arguments: {
                                        'DateTime' : formatted,
                                        'selectedUnit' : isSelectedUnit,
                                      });
                                    });
                                  },
                                  icon: Icon(Icons.create),
                                  label: Text("Create"),
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 140.0,
                    color: Colors.grey[800],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Future createUser({required String rank, required String name, required bool reg}) async {
    final docUser = FirebaseFirestore.instance.collection(fbUnit[isSelectedUnit])
    .doc();

    final json = {
      'RANK': rank,
      'NAME': name,
      'isRegular' : reg
    };

    await docUser.set(json);
  }
}


