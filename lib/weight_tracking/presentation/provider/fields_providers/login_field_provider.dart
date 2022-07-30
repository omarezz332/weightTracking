import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/core/login_request.dart';

/// This is the provider for the login field.
final Provider<LoginFieldProvider> loginFieldProviderRef =
    Provider<LoginFieldProvider>(
  (ProviderRef<LoginFieldProvider> ref) => LoginFieldProvider(),
);

/// This is the provider for the login field.
class LoginFieldProvider {
  /// This is the login request.
  LoginRequest loginRequest = const LoginRequest();

  /// This is the key for the form.
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  /// This is the function to register a new key.
  void registerNewKey() {
    loginKey = GlobalKey<FormState>();
  }

  /// This is the function to validate the form.
  bool validate() {
    if (loginKey.currentState!.validate()) {
      loginKey.currentState!.save();
      return true;
    }
    return false;
  }

  /// This is the function to set the email.
  void setEmail(String email) {
    loginRequest = loginRequest.copyWith(email: email);
  }

  /// This is the function to set the password.
  void setPassword(String password) {
    loginRequest = loginRequest.copyWith(password: password);
  }
}
