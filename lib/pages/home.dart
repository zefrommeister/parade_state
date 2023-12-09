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
import 'package:parade_state/pages/completion.dart';


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

  List<Color> colorList = [
    Colors.pink,
    Colors.blue,
    Colors.green,
    Colors.yellow
  ];
  List<Alignment> alignmentList = [
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topRight,
    Alignment.topLeft,
  ];
  int index = 0;
  Color bottomColor = Colors.pink;
  Color topColor = Colors.yellow;
  Alignment begin = Alignment.bottomLeft;
  Alignment end = Alignment.topRight;

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        bottomColor = Colors.blue;
      });
    });
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
    'MA',
    'SHRO',
    'LATE',
    'COURSE',
    'RSO (ARI)',
    'RSO (OTHERS)',
    'RSO (PSYCH)',
    'RSI',
    'HRN',
    'Ag+',
    'AO',
    'DB',
    'RTC',
    'LEAVE (ANN)',
    'LEAVE (OTHERS)',
    'OFF',
    'SOL',
    'UNCONTACTABLE',
    'AW',
  ];

  List<String> items2 = <String>[
    'PRESENT',
    'OTHERS',
    'MC',
    'MA',
    'SHRO',
    'LATE',
    'COURSE',
    'RSO(ARI)',
    'RSO(OTHERS)',
    'RSO (PSYCH)',
    'RSI',
    'HRN',
    'Ag+',
    'AO',
    'DB',
    'RTC',
    'LEAVE (ANN)',
    'LEAVE (OTHERS)',
    'OFF',
    'SOL',
    'UNCONTACTABLE',
    'AW',
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

  List<String> psUnit = ['Alpha', 'Bravo', 'Charlie', 'Delta', 'Echo', 'Foxtrot',
    'Golf', 'Hotel', 'India', 'Juliett', 'Kilo', 'Lima', 'Mike', 'November', 'Oscar', 'Papa', 'Quebec', 'Romeo', 'Sierra', 'Tango'];

  List<String> fbUnit = ['alphapstate', 'bravopstate', 'charliepstate', 'deltapstate', 'echopstate', 'foxtrotpstate',
    'golfpstate', 'hotelpstate', 'indiapstate', 'juliettpstate', 'kilopstate', 'limapstate', 'mikepstate', 'novemberpstate', 'oscarpstate', 'papapstate', 'quebecpstate', 'romeopstate', 'sierrapstate', 'tangopstate'];

  
  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    formatted = data['DateTime'];
    isSelectedUnit = data['selectedUnit'];

    return Scaffold(
      appBar: AppBar(
        title: Text(psUnit[isSelectedUnit] + ' PARADE STATE'),
        centerTitle: true,
        backgroundColor: Colors.green[300],
        elevation: 0,
      ),

        body: Stack(
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 2),
              onEnd: () {
                setState(() {
                  index = index + 1;
                  // animate the color
                  bottomColor = colorList[index % colorList.length];
                  topColor = colorList[(index + 1) % colorList.length];

                  /// animate the alignment
                  //begin = alignmentList[index % alignmentList.length];
                  //end = alignmentList[(index + 2) % alignmentList.length];
                });
              },
              decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: begin, end: end, colors: [bottomColor, topColor]
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
                  SizedBox(height: 25.0),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                        "Created by CPL Yao Teck",
                        style: TextStyle(
                          letterSpacing: 2.0,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                    ),

                  ),
                  Divider(
                    height: 50.0,
                    color: Colors.grey[700],
                    thickness: 1.2,
                  ),

                         SingleChildScrollView(
                           physics: ScrollPhysics(),
                           child: Column(
                            children: [
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: usersList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        shadowColor: Colors.amber,
                                          elevation: 12,
                                          color: Colors.grey[200],
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: IconButton(
                                                    onPressed: () async {

                                                      showDialog(
                                                          context: context,
                                                          builder: (context) => AlertDialog(
                                                            title: Text('Delete this user?'),
                                                            content: Text('Do you wish to delete this user?'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () async {
                                                                  var collection = FirebaseFirestore.instance.collection(fbUnit[isSelectedUnit]);
                                                                  var snapshot = await collection.where('NAME', isEqualTo: usersList[index]['NAME']).get();
                                                                  await snapshot.docs.first.reference.delete();

                                                                  final snackBar2 = SnackBar(
                                                                    content: Text("User deleted!"),
                                                                    backgroundColor: Colors.green,
                                                                  );
                                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar2);

                                                                  setState((){
                                                                    Navigator.pushReplacementNamed(context, '/completion', arguments: {
                                                                      'DateTime' : formatted,
                                                                      'selectedUnit' : isSelectedUnit,
                                                                    });
                                                                  });
                                                                },
                                                                child: Text('Yes'),
                                                              ),
                                                              TextButton(onPressed: () async {
                                                                setState((){
                                                                  Navigator.pushReplacementNamed(context, '/completion', arguments: {
                                                                    'DateTime' : formatted,
                                                                    'selectedUnit' : isSelectedUnit,
                                                                  });
                                                                });
                                                              },
                                                                child: Text('No'),
                                                              ),
                                                            ],
                                                          ),
                                                      );
                                                    },
                                                    icon: Icon(Icons.delete),
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Text(
                                                  "RANK: ", //+ usersList[index]['RANK'],
                                                  style: TextStyle(
                                                    letterSpacing: 2.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17.0,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                                DropdownButton<String>(
                                                  onChanged: (String? newValue) async {

                                                    var collection = FirebaseFirestore.instance.collection(fbUnit[isSelectedUnit]);
                                                    var snapshot = await collection.where('NAME', isEqualTo: usersList[index]['NAME']).get();

                                                    setState((){
                                                      dropdownRankValue[index] = newValue!;
                                                      snapshot.docs.first.reference.update(
                                                          {"RANK": dropdownRankValue[index]}
                                                      );

                                                      Navigator.pushReplacementNamed(context, '/completion', arguments: {
                                                        'DateTime' : formatted,
                                                        'selectedUnit' : isSelectedUnit,
                                                      });
                                                    });

                                                    final snackBar = SnackBar(
                                                      content: Text("Rank changed!"),
                                                      backgroundColor: Colors.green,
                                                    );
                                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                                  },
                                                  value: dropdownRankValue[index] = usersList[index]['RANK'],
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
                                                  "NAME: " + usersList[index]['NAME'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17.0,
                                                    letterSpacing: 2.0,
                                                    color: Colors.black54,
                                                  ),
                                                ),

                                                SizedBox(height: 8.0),
                                                Text(
                                                  'AM status',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17.0,
                                                    color: Colors.grey[600],
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
                                                    fontSize: 15.0,
                                                    color: Colors.blue[400],
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
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17.0,
                                                    color: Colors.grey[600],
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
                                                    fontSize: 15.0,
                                                    color: Colors.blue[400],
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
                                          ),
                                      ),
                                    );
                                  }

                              ),
                            ],
                        ),
                         ),

                    Divider(
                      height: 70.0,
                      color: Colors.grey[800],
                    ),
                    Center(
                      child: RaisedButton.icon(
                        onPressed: () async {
                          final snackBar5 = SnackBar(
                            content: Text("Please wait..."),
                            backgroundColor: Colors.orange,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar5);
                          try {
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

                          final snackBar = SnackBar(
                            content: Text("Parade State sent!"),
                            backgroundColor: Colors.green,
                          );



                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          } catch (e) {

                            final snackBar3 = SnackBar(
                              content: Text("ERROR! Please contact help immediately"),
                              backgroundColor: Colors.red,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar3);
                          }


                        },
                        icon: Icon(Icons.send),
                        label: Text('Send'),
                        color: Colors.grey[400],
                      ),
                    )

                  ],

                ),
              ),

            ),
          ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            Navigator.pushReplacementNamed(context, '/create', arguments: {
              'DateTime': formatted,
              'selectedUnit': isSelectedUnit,
              });
            },
          );
        }),
    );


  }

}
