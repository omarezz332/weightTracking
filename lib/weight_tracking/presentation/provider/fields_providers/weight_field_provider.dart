import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/core/login_request.dart';
import '../../../domain/core/weight.dart';

/// This is the provider for the login field.
final Provider<WeightFieldProvider> weightFieldProviderRef =
    Provider<WeightFieldProvider>(
  (ProviderRef<WeightFieldProvider> ref) => WeightFieldProvider(),
);

/// This is the provider for the login field.
class WeightFieldProvider {
  /// This is the login request.
  late Weight weightClass=Weight();

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

  /// This is the function to set the weight.
  void setWeight(String weight) {
    weightClass =weightClass.copyWith(weight: weight);
  }

  /// This is the function to set the password.
  void setDate(String date) {
    weightClass = weightClass.copyWith(date:date );
  }
}
