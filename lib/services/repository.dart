import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:donate_blood/services/authentication.dart';

class Repository {
  Repository(this._firestore) : assert(_firestore != null);
  final FirebaseFirestore _firestore;
  List<dynamic> list = new List();

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
      int amount, DateTime date) {
    return _firestore
        .collection('donations')
        .add({
          'amount': amount,
          'userId': _firestore.doc('/users/' + user),
          'nurseId': _firestore.doc('/users/' + nurse),
          'donationType': donationType,
          'donationDate': date
        })
        .then((value) => print("donation added"))
        .catchError((error) => print("Failed to add donation: $error"));
  }

  Future<String> updateUser(String fullName, DateTime dateOfBirth,
      String phoneNumber, String bloodGroup) async {
/*    Map<String,dynamic> fields = HashMap<String,dynamic>();
    if(fullName.isNotEmpty)
      fields.addAll({'fullName':fullName.trim()});
    if( phoneNumber.isNotEmpty)
      fields.addAll({'phoneNumber': phoneNumber.trim()});
    if(bloodGroup.isNotEmpty)
      fields.addAll({'bloodGroup':bloodGroup.trim()});*/

    return await _firestore
        .collection('users')
        .doc(Auth().getCurrentUser().uid)
        .update({
          'fullName': fullName,
          'dateOfBirth': dateOfBirth,
          'phoneNumber': phoneNumber,
          'bloodGroup': bloodGroup
        })
        .then((value) => "User data has been successfully updated.")
        .catchError((error) => "User data has not been updated. Error: $error");
  }

  Future<void> getUsersMap() async {
    list.clear();
    var getter = await _firestore.collection('users').get();
    /*getter.docs.forEach((element) {
      list.add({"display": element.data()['fullName'], "value": element.id});
    });*/

    list = getter.docs.map((element) => ({"display": element.data()['fullName'], "value": element.id})).toList();
  }

  List<dynamic> getUsersList(){
    return list;
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
