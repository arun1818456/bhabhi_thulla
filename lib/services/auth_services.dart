


import '../../exports.dart';

class SocialAuth {
  Future<UserCredential> signInWithGoogle() async {
    const List<String> scopes = <String>['email', 'profile'];
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      scopes: scopes,
    ).signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    var data = await FirebaseAuth.instance.signInWithCredential(credential);
    return data;
  }
}
