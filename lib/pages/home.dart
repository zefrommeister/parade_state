import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gsheets/gsheets.dart';
import 'package:parade_state/main.dart';
import 'package:flutter/material.dart';
import 'package:parade_state/services/parade_state.dart';
import 'package:parade_state/pages/loading.dart';
import 'package:parade_state/services/user_sheets_api.dart';
import 'package:parade_state/pages/listFile.dart';
import 'package:parade_state/services/database.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List usersList = [];
  int gsIndex = 0;
  Map data = {};
  String formatted = '1';
  String pStateRank = '';
  String pStateName = '';
  List <String> dropdownRankValue = <String>[];
  List <String> dropdownAMValue = <String>[];
  List <String> dropdownPMValue = <String>[];

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getDBList();

    if (resultant == null)
      {
        print("Unable to retrieve");
      }
    else {
      setState(() {
        usersList = resultant;
        gsIndex = usersList.length;
        isSelectedUnit = data['selectedUnit'];
        globalGSIndex = gsIndex;
        for (var i = 0; i < gsIndex; i++)
          {
            dropdownAMValue.add('PRESENT');
            dropdownPMValue.add('PRESENT');
            dropdownRankValue.add('REC');
          }
      });
    }
  }


  List<String> items = <String>[
    'PRESENT',
    'OTHERS',
    'MC',
    'RSO (ARI)',
    'RSO (OTHERS)',
    'AO',
    'DB',
    'RTC',
    'LEAVE',
    'OFF',
    'SOL',
  ];

  List<String> items2 = <String>[
    'PRESENT',
    'OTHERS',
    'MC',
    'RSO (ARI)',
    'RSO (OTHERS)',
    'AO',
    'DB',
    'RTC',
    'LEAVE',
    'OFF',
    'SOL',
  ];

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

  List<String> psUnit = ['ECHQ', 'SUPPLY SECT', 'COSEMB', 'CONS', 'COSEL', 'CODB',
    'CP', 'FLEET', 'SPSEL', 'SPSEMB', 'SPDB', '35SCE', 'ARMCEG', 'ADF', 'CBRE'];

  List<String> fbUnit = ['echqpstate', 'sspstate', 'cosembpstate', 'conspstate', 'coslpstate', 'codbpstate',
    'cppstate', 'fleetpstate', 'spslpstate', 'spsembpstate', 'spdbpstate', '35scepstate', 'armcegpstate', 'adfpstate', 'cbrepstate'];

  @override
  Widget build(BuildContext context) {


    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    print(data);
    formatted = data['DateTime'];
    isSelectedUnit = data['selectedUnit'];

    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text(psUnit[isSelectedUnit] + ' Parade State'),
        centerTitle: true,
        backgroundColor: Colors.grey[500],
        elevation: 0,


      ),

        body: Padding(
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
                color: Colors.grey[700],
              ),

                     Column(
                      children: [
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: usersList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          onPressed: () async {

                                          },
                                          icon: Icon(Icons.delete),
                                          color: Colors.red,
                                        ),
                                      ),
                                      Text(
                                        "RANK: ", //+ usersList[index]['RANK'],
                                        style: TextStyle(
                                          letterSpacing: 2.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      DropdownButton<String>(
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownRankValue[index] = newValue!;
                                          });
                                        },
                                        value: dropdownRankValue[index] = usersList[index]['RANK'],
                                        style: TextStyle(
                                          color: Colors.blue[500],
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
                                        "NAME: " + usersList[index]['NAME'],
                                        style: TextStyle(
                                          letterSpacing: 2.0,
                                          color: Colors.grey,
                                        ),
                                      ),

                                      SizedBox(height: 12.0),
                                      Text(
                                        'AM status',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 2.0,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      DropdownButton<String>(
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownAMValue[index] = newValue!;
                                          });
                                        },
                                        value: dropdownAMValue[index].toString(),
                                        style: TextStyle(
                                          color: Colors.blue[500],
                                        ),
                                        items: items.map<DropdownMenuItem<String>>(
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
                                        'PM status',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 2.0,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      DropdownButton<String>(
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownPMValue[index] = newValue!;
                                          });
                                        },
                                        value: dropdownPMValue[index].toString(),
                                        style: TextStyle(
                                          color: Colors.blue[500],
                                        ),
                                        items: items2.map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          },
                                        ).toList(),
                                      ),

                                    ],
                                  ),
                              );
                            }

                        ),
                      ],
                    ),

                Divider(
                  height: 70.0,
                  color: Colors.grey[700],
                ),
                Center(
                  child: RaisedButton.icon(
                    onPressed: () async {

                      await UserSheetsApi.init();
                      //await UserSheetsApi.delete();

                      final result = <ParadeState>[
                      for (int i = 0; i<gsIndex; i++)
                          ParadeState(
                              rank: usersList[i]['RANK'],
                              name: usersList[i]['NAME'],
                              date: formatted,
                              morningState: dropdownAMValue[i],
                              afternoonState: dropdownPMValue[i],
                      ),
                      ];


                      final jsonPS = result.map((psStatus) => psStatus.toJson()).toList();

                      await UserSheetsApi.insert(jsonPS);

                      final snackBar = SnackBar(content: Text("Parade State sent"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      /*for (int i = 0; i < gsIndex; i++)
                        {
                        Map <String, dynamic> pStatus =
                        {
                          ParadeStateFields.rank: usersList[i]['RANK'],
                          ParadeStateFields.name: usersList[i]['NAME'],
                          ParadeStateFields.morningState: dropdownAMValue,
                          ParadeStateFields.afternoonState: dropdownPMValue,
                          ParadeStateFields.date: formatted,
                        };
                        print([pStatus]);
                        */
                       // await UserSheetsApi.insert([result.toJson()]);
                      //}

                    },
                    icon: Icon(Icons.save),
                    label: Text('Save'),
                    color: Colors.grey[400],
                  ),
                )
              ],

            ),
          ),

        ),
    );


  }

}
