import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_blood/services/authentication.dart';

class Repository {
  Repository(this._firestore) : assert(_firestore != null);
  final FirebaseFirestore _firestore;

  Stream<DocumentSnapshot> getUserData() {
    return _firestore.collection('users').doc(Auth().getCurrentUser().uid).snapshots();
  }

  Query getUserDonors() {
    return _firestore.collection('donations').where('userId', isEqualTo: Auth().getCurrentUser().uid);
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
