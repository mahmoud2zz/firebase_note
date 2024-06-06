import 'package:firebase_auth/firebase_auth.dart';

import '../models/process_response.dart';

class FbAuthController {
  FbAuthController._();

  static FbAuthController? instance;

  factory FbAuthController() {
    return instance ??= FbAuthController._();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<ProcessResponse> createAccountWithEmailAndPassword(
      email, password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.sendEmailVerification();

      await _auth.signOut();

      return ProcessResponse('Registered successfully verifier email');
    } on FirebaseAuthException catch (e) {
      return ProcessResponse(e.message!, false);
    }
  }

  Future<ProcessResponse> signInWithEmailAndPassword(String email,String  password) async {
    try {
      UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);


      return ProcessResponse('LoggedIn successfully verifier email');
    } on FirebaseAuthException catch (e) {
      return ProcessResponse(e.message!, false);
    }

  }

  bool get loggedIn=>_auth.currentUser!=null;
  Future<void> signOut() => _auth.signOut();
  User get user =>_auth.currentUser!;
}
