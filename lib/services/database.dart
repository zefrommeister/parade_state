import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parade_state/main.dart';

List<String> fbUnit = ['alphapstate', 'bravopstate', 'charliepstate', 'deltapstate', 'echopstate', 'foxtrotpstate',
  'golfpstate', 'hotelpstate', 'indiapstate', 'juliettpstate', 'kilopstate', 'limapstate', 'mikepstate', 'novemberpstate', 'oscarpstate', 'papapstate', 'quebecpstate', 'romeopstate', 'sierrapstate', 'tangopstate'];


class DatabaseManager {
  final CollectionReference dbList = FirebaseFirestore.instance.collection(fbUnit[isSelectedUnit]);

  Future getDBList() async {

    List itemsList = [];

    try {
      await dbList.orderBy('isRegular', descending: true).get().then((querySnapshot) {
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