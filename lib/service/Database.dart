import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
      Future addEvent(Map<String, dynamic> addEventMap, String id)async{
        return await FirebaseFirestore.instance
            .collection("events")
            .doc(id)
            .set(addEventMap);
      }
}