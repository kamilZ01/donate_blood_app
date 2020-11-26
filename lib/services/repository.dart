import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_blood/services/authentication.dart';

class Repository {
  Repository(this._firestore) : assert(_firestore != null);
  final FirebaseFirestore _firestore;

  CollectionReference events = FirebaseFirestore.instance.collection('events');

  Stream<DocumentSnapshot> getUserData() {
    return _firestore
        .collection('users')
        .doc(Auth().getCurrentUser().uid)
        .snapshots();
  }

  Query getUserDonors() {
    return _firestore
        .collection('donations')
        .where('userId', isEqualTo: Auth().getCurrentUser().uid);
  }

  // CollectionReference getEventsCollection() {
  //   return events = FirebaseFirestore.instance.collection('events');
  // }

  Future<void> addEvent(
      String eventType, String location, String typeDonation) {
    return events
        .add({
          'eventType': eventType,
          'location': location,
          'typeDonation': typeDonation
        })
        .then((value) => print("events added"))
        .catchError((error) => print("Failed to add event: $error"));
  }

  List getBloodGroups() {
    return [
      {
        "display": "AB+",
        "value": "AB+",
      },
      {
        "display": "AB-",
        "value": "AB-",
      },
      {
        "display": "A+",
        "value": "A+",
      },
      {
        "display": "A-",
        "value": "A-",
      },
      {
        "display": "B+",
        "value": "B+",
      },
      {
        "display": "B-",
        "value": "B-",
      },
      {
        "display": "0+",
        "value": "0+",
      },
      {
        "display": "0-",
        "value": "0-",
      }
    ];
  }
}
