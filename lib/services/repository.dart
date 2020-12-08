import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_blood/services/authentication.dart';

class Repository {
  Repository(this._firestore) : assert(_firestore != null);
  final FirebaseFirestore _firestore;

  CollectionReference events = FirebaseFirestore.instance.collection('events');
  CollectionReference donations =
      FirebaseFirestore.instance.collection('donations');

  Stream<DocumentSnapshot> getUserData() {
    return _firestore
        .collection('users')
        .doc(Auth().getCurrentUser().uid)
        .snapshots();
  }

  Query getUserDonations() {
    return _firestore.collection('donations').where('userId',
        isEqualTo: _firestore.doc('/users/' + Auth().getCurrentUser().uid));
  }

  Query getNurseCollections() {
    return _firestore.collection('donations').where('nurseId',
        isEqualTo: _firestore.doc('/users/' + Auth().getCurrentUser().uid));
  }

  Future<void> addEvent(
      String eventType, String location, String typeDonation, DateTime date) {
    return events
        .add({
          'eventType': eventType,
          'location': location,
          'typeDonation': typeDonation,
          'date': date
        })
        .then((value) => print("events added"))
        .catchError((error) => print("Failed to add event: $error"));
  }

  Future<void> addDonations(String user, String donationType, int amount) {
    return donations
        .add({'userId': user, 'donationType': donationType, 'amount': amount})
        .then((value) => print("donation added"))
        .catchError((error) => print("Failed to add donations: $error"));
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
