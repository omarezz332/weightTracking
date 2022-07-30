import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/datasource/remote/apis/authentication_api.dart';
import '../../../data/datasource/remote/interfaces/i_authentication_api.dart';
import '../fields_providers/register_field_provider.dart';

final registerNotifierProviderRef =
    StateNotifierProvider<RegisterNotifier, bool>((
  ref,
) {
  return RegisterNotifier(
    ref.read(authenticationApi),
    ref.read(registerFieldProviderRef),
  );
});

class RegisterNotifier extends StateNotifier<bool> {
  final IAuthApi _api;
  final RegisterFieldProvider _registerFieldProvider;
  RegisterNotifier(this._api, this._registerFieldProvider) : super(false);

  Future<User?> register() async {
    state = true;
    try {
      final response =
          await _api.register(_registerFieldProvider.registerRequest);
      return response;
    } catch (e) {
      return null     ;
    } finally {
      state = false;
    }
  }
}
