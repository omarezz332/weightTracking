import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../settings/helpers/ui_helpers.dart';
import '../../../../domain/core/login_request.dart';
import '../../../../domain/core/register_request.dart';
import '../interfaces/i_authentication_api.dart';
import 'package:http/http.dart' as http;

final authenticationApi = Provider<IAuthApi>(
      (ref) => AuthenticationApi(),
);

class AuthenticationApi implements IAuthApi {

  AuthenticationApi();
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  @override
  Future<User?> login(LoginRequest request) async {
    //final url = Uri.parse(kPosts);
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
          email: request.email, password: request.password);

      log(response.toString());
      return response.user;
    }on FirebaseAuthException catch  (e) {
      UiHelpers.showNotification(e.code,);

      print("Failed with error code: ${e.code}");

      print(e.message);
    } on SocketException catch (e) {
      UiHelpers.showNotification("Check Your Network ",isError: true,);
      print("Failed with error code: ${e}");
      print(e.message);
    } on HttpException catch (e) {
      print('Failed with error code: ${e}');
      print(e.message);
    } on Exception catch (e) {
      print('Failed with error code: ${e}');
      print(e);
    }

    // final LoginData successResponse =
    // LoginData.fromJson(response as Map<String, dynamic>);

  }


  @override
  Future<User?> register(RegisterRequest request) async {
    try {
      final UserCredential response = await _firebaseAuth.createUserWithEmailAndPassword(
          email: request.email, password: request.password);
      log(response.toString());
      // final Null successResponse = null;
      //LoginData.fromJson(response as Map<String, dynamic>);
      return response.user;
    }
    on FirebaseAuthException catch (e) {
      UiHelpers.showNotification(e.code, isError: true,);

      print('Failed with error code: ${e.code}');

      print(e.message);
    } on SocketException catch (e) {
      UiHelpers.showNotification("Check Your Network ", isError: true,);
      print('Failed with error code: ${e}');
      print(e.message);
    } on HttpException catch (e) {
      print('Failed with error code: ${e}');
      print(e.message);
    } on Exception catch (e) {
      print('Failed with error code: ${e}');
      print(e);
    }
  }
}
