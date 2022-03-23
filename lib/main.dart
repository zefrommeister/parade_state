import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
      }));

    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
    //runApp(MyApp());
}
/*
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => FirebaseFirestore.instance
          .collection('testing')
          .add({'timestamp': Timestamp.fromDate(DateTime.now())}),
          child: Icon(Icons.add),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('testing').snapshots(),
          builder: (
          BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot,
          ) {
            if (!snapshot.hasData) return const SizedBox.shrink();
            return ListView.builder(
                itemCount: (snapshot.data!).docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final docData = (snapshot.data!).docs[index];
                  final dateTime = (docData['timestamp'] as Timestamp).toDate();
                  return ListTile(
                    title: Text(dateTime.toString()),
                  );
                },

            );
            },
        ),
      ),
    );
  }
}*/

