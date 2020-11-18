import 'package:donate_blood/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  Future<void> signOut();

  Future<String> signUp(String email, String password);

  Future<User> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<bool> isEmailVerified();

  Future<String> changeEmail(String email);

  Future<String> changePassword(String password);

  Future<String> deleteUser();

  Future<void> sendPasswordResetMail(String email);
}

class Auth implements BaseAuth {
  static Auth _auth;
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Auth._internal();

  factory Auth() => _auth ?? Auth._internal();

  @override
  Future<String> signIn(String email, String password) async {
    UserCredential result;
    try {
      result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return S.current.userNotFound;
          break;
        case 'wrong-password':
          return S.current.wrongPassword;
          break;
        case 'user-disabled':
          return S.current.wrongPassword;
          break;
        case 'invalid-email':
          return S.current.invalidEmail;
          break;
        default:
          return S.current.loginError(e.message);
      }
    }
    return result.user.uid;
  }

  @override
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  @override
  Future<String> signUp(String email, String password) async {
    UserCredential result;
    try {
      result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          return S.current.weakPassword;
          break;
        case 'email-already-user':
          return S.current.emailAlreadyUser;
          break;
        case 'invalid-email':
          return S.current.invalidEmail;
          break;
        case 'operation-not-allowed':
          return S.current.operationNotAllowed;
          break;
        default:
          return S.current.loginError(e.message);
      }
    }
    return result.user.uid;
  }

  @override
  Future<User> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<void> sendEmailVerification() async {
    await _firebaseAuth.currentUser.sendEmailVerification();
  }

  @override
  Future<bool> isEmailVerified() async {
    return _firebaseAuth.currentUser.emailVerified;
  }

  @override
  Future<String> changeEmail(String email) async {
    await _firebaseAuth.currentUser.updateEmail(email).then((_) {
      return S.current.changedEmail;
    }).catchError((e) {
      return S.current.notChangedEmail(e.toString());
    });
    return null;
  }

  @override
  Future<String> changePassword(String password) async {
    await _firebaseAuth.currentUser.updatePassword(password).then((_) {
      return S.current.changedPassword;
    }).catchError((e) {
      return S.current.notChangedPassword(e.toString());
    });
    return null;
  }

  @override
  Future<String> deleteUser() async {
    await _firebaseAuth.currentUser.delete().then((_) {
      return S.current.userDeleted;
    }).catchError((e) {
      return S.current.notUserDeleted(e.toString());
    });
    return null;
  }

  @override
  Future<void> sendPasswordResetMail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}