import 'package:firebase_auth/firebase_auth.dart';
///
/// This class is used to manage the authentication state locally .
abstract class ITokenRepository {
  Future<String> getToken();
  Future<void> deleteToken();
  Future<void> setToken(String newToken);
  Future<void> setUser(User newUser);
  Future<User?> getUser();
}
