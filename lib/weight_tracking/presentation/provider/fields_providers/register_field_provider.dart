import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/core/register_request.dart';

/// This is the provider for the register field.
final Provider<RegisterFieldProvider> registerFieldProviderRef =
    Provider<RegisterFieldProvider>(
        (ProviderRef<RegisterFieldProvider> ref) => RegisterFieldProvider(),);
/// This is the provider for the register fields.
class RegisterFieldProvider {
  /// This is the register request.
  RegisterRequest registerRequest = const RegisterRequest();
/// This is the key for the form.
  final GlobalKey<FormState> registerKey = GlobalKey<FormState>();
/// This is the function to register a new key.
  bool validate() {
    if (registerKey.currentState!.validate()) {
      registerKey.currentState!.save();
      return true;
    }
    return false;
  }
/// This is the function to set the email.
  void setEmail(String email) {
    registerRequest = registerRequest.copyWith(email: email);
  }
/// This is the function to set the password.
  void setPassword(String password) {
    registerRequest = registerRequest.copyWith(password: password);
  }
}
