import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parade_state/main.dart';

List<String> fbUnit = ['echqpstate', 'sspstate', 'cosembpstate', 'conspstate', 'coslpstate', 'codbpstate',
  'cppstate', 'fleetpstate', 'spslpstate', 'spsembpstate', 'spdbpstate', '35scepstate', 'armcegpstate', 'adfpstate', 'cbrepstate'];


class DatabaseManager {
  final CollectionReference dbList = FirebaseFirestore.instance.collection(fbUnit[isSelectedUnit]);

  Future getDBList() async {

    List itemsList = [];

    try {
      await dbList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data());
        });
      });
      return itemsList;
    }
    catch (e) {
      print(e.toString());
      return null;
    }

  }
}