import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:donate_blood/services/authentication.dart';

class Repository {
  Repository(this._firestore) : assert(_firestore != null);
  final FirebaseFirestore _firestore;

  Stream<DocumentSnapshot> getUserData() {
    return _firestore
        .collection('users')
        .doc(Auth().getCurrentUser().uid)
        .snapshots();
  }

  Query getUsers() {
    return  _firestore.collection('users');
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
    return _firestore
        .collection('events')
        .add({
          'eventType': eventType,
          'location': location,
          'typeDonation': typeDonation,
          'date': date
        })
        .then((value) => print("events added"))
        .catchError((error) => print("Failed to add event: $error"));
  }

  Future<void> addDonation(String user, String nurse, String donationType,
      int amount, DateTime donationDate) {
    return _firestore
        .collection('donations')
        .add({
          'amount': amount,
          'userId': _firestore.doc('/users/' + user),
          'nurseId': _firestore.doc('/users/' + nurse),
          'donationType': donationType,
          'donationDate': donationDate
        })
        .then((value) => print("donation added"))
        .catchError((error) => print("Failed to add donation: $error"));
  }

  Future<String> updateUser(String fullName, DateTime dateOfBirth,
      String phoneNumber, String bloodGroup) async {
    return await _firestore
        .collection('users')
        .doc(Auth().getCurrentUser().uid)
        .update({
          'fullName': fullName,
          'dateOfBirth': dateOfBirth,
          'phoneNumber': phoneNumber,
          'bloodGroup': bloodGroup
        })
        .then((value) => S.current.userDataHasBeenSuccessfullyUpdated)
        .catchError((error) => S.current.userDataHasNotBeenUpdated + '$error');
  }

  List getBloodGroups() {
    return [
      {
        "value": "AB+",
      },
      {
        "value": "AB-",
      },
      {
        "value": "A+",
      },
      {
        "value": "A-",
      },
      {
        "value": "B+",
      },
      {
        "value": "B-",
      },
      {
        "value": "0+",
      },
      {
        "value": "0-",
      }
    ];
  }

  List getDonationType() {
    return [
      {
        "value": S.current.wholeBlood,
      },
      {
        "value": S.current.plasma,
      },
      {
        "value": S.current.platelets,
      },
    ];
  }
}
