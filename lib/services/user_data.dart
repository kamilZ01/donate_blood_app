import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_blood/services/authentication.dart';

class UserData {
  static UserData _userData;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference donations =
      FirebaseFirestore.instance.collection('donations');

  UserData._internal();

  factory UserData() => _userData ?? UserData._internal();

  Stream<DocumentSnapshot> getUserData() {
    return users.doc(Auth().getCurrentUser().uid).snapshots();
  }

  Query getUserDonors() {
    return donations.where('userId', isEqualTo: Auth().getCurrentUser().uid);
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
