import 'package:firebase_auth/firebase_auth.dart';

class LoginService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signIn() async {
    try {
      return _firebaseAuth.signInAnonymously();
    } catch (e) {
      print('error from signIn in login service');
    }
  }

  bool isUserSignedIn() {
    return _firebaseAuth.currentUser != null;
  }

  Future signOut() async {
     try {
      return _firebaseAuth.signOut();
    } catch (e) {
      print('error from signOut in login service');
    }
  }

}
