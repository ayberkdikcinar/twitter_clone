import '../model/user_model.dart';

abstract class AuthBase {
  Future<UserModel> signIn();
  Future<UserModel> currentUser();
  Future<UserModel> signInWithGoogle();
  Future<bool> signOut();
  Future<UserModel> signInWithEmail(String email, String password);
  Future<UserModel> createUserWithEmail(String email, String password);
}
