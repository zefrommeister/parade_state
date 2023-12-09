import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:parade_state/pages/home.dart';
import 'package:parade_state/main.dart';


class Completion extends StatefulWidget {
  const Completion({Key? key}) : super(key: key);

  @override
  _CompletionState createState() => _CompletionState();
}

class _CompletionState extends State<Completion> {

  Map data = {};
  String formatted = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToHome();
  }

  navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 2500), () {});
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'DateTime' : formatted,
      'selectedUnit' : isSelectedUnit,
    });
  }

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    formatted = data['DateTime'];

    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 80.0,

        ),
      ),
    );
  }
}

