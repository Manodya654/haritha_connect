import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
      Future addEvent(Map<String, dynamic> addEventMap, String id)async{
        return await FirebaseFirestore.instance
            .collection("events")
            .doc(id)
            .set(addEventMap);
      }

      Future addProfile(Map<String, dynamic> addprofileMap, String id)async{
        return await FirebaseFirestore.instance
            .collection("Profile")
            .doc(id)
            .set(addprofileMap);
      }

      Future<Stream<QuerySnapshot>> getevent()async{
        return await FirebaseFirestore.instance
            .collection("events")
            .snapshots();
      }

      Stream<QuerySnapshot> getEvents() {
        return FirebaseFirestore.instance.collection('events').snapshots();
      }

}