import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parade_state/pages/createUser.dart';
import 'package:parade_state/pages/home.dart';
import 'package:parade_state/services/user_sheets_api.dart';
import 'package:parade_state/pages/loading.dart';
import 'package:parade_state/pages/completion.dart';
import 'package:parade_state/pages/listFile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parade_state/pages/passcode.dart';

int isSelectedUnit = 1;
int globalGSIndex = 0;


Future main() async {

  runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => Home(),
        '/completion': (context) => Completion(),
        '/list': (context) => ListFile(),
        '/pass': (context) => Pass(),
        '/API': (context) => UserSheetsAPI(),
        '/create': (context) => Create(),
      }

      )
  );

    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
    //runApp(MyApp());

}







