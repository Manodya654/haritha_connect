import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addEvent(Map<String, dynamic> addEventMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("events")
        .doc(id)
        .set(addEventMap);
  }

  Future updateEvent(Map<String, dynamic> addEventMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("events")
        .doc(id)
        .set(addEventMap);
  }

  Future updateProfile(Map<String, dynamic> addprofileMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("user")
        .doc(id)
        .update(addprofileMap);
  }

  Future<Stream<QuerySnapshot>> getevent() async {
    return await FirebaseFirestore.instance.collection("events").snapshots();
  }
}
