import 'package:parade_state/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:parade_state/pages/home.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:parade_state/pages/loading.dart';
import 'package:parade_state/services/user_sheets_api.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Pass extends StatefulWidget {
  const Pass({Key? key}) : super(key: key);

  @override
  _PassState createState() => _PassState();
}

class _PassState extends State<Pass> {

  Map data = {};
  int selectedUnit = 0;
  String unit = '';

  void getTime() async {
    Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone/Asia/Singapore'));
    Map data = jsonDecode(response.body);

    String datetime = data['datetime'];
    DateTime now = DateTime.parse(datetime.substring(0,26));
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    final String formatted = formatter.format(now);

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'DateTime' : formatted,
      'Unit' : unit,
      'selectedUnit' : isSelectedUnit,
    });

    print(formatted);
  }


  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    print(data);
    String pw = data['Passcode'];
    unit = data['Unit'];
    selectedUnit = data['selectedUnit'];
    isSelectedUnit = selectedUnit;

    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "Enter the Passcode",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                  ),
              ),
              SizedBox(height: 30.0),
              PinCodeTextField(
                  appContext: context,
                  length: 6,
                  onChanged: (value) {
                  },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  inactiveColor: Colors.orange,
                  activeColor: Colors.green,
                  selectedColor: Colors.brown,
                ),
                onCompleted: (value) {
                    if (value == pw){
                      setState(() {
                        getTime();
                        print(isSelectedUnit);
                      });
                     print('Good');
                    }
                    else {
                      print('Bad');
                      final snackBar = SnackBar(content: Text("Passcode incorrect! Please call for help"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                },
              ),
            ],
          ),
        )
      ),
    );

  }
}
