import 'package:firebase_auth/firebase_auth.dart';
import '../../../../domain/core/login_request.dart';
import '../../../../domain/core/register_request.dart';

abstract class IAuthApi {
  Future<User?> login(LoginRequest request);

  Future<User?> register(RegisterRequest request);

}
