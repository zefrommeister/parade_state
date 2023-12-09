import 'package:parade_state/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:parade_state/pages/listFile.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}


class _LoadingState extends State<Loading> {

  String hString = 'green';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getTime();
    navigateToList();
  }

  navigateToList() async {
    await Future.delayed(Duration(milliseconds: 2500), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ListFile()));
  }



  @override
  Widget build(BuildContext context) {
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
