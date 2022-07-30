import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/datasource/remote/apis/authentication_api.dart';
import '../../../data/datasource/remote/interfaces/i_authentication_api.dart';
import '../fields_providers/login_field_provider.dart';
import '../token_repository_provider.dart';
import 'authentication_state.dart';


final authenticationNotifierProvider =
    StateNotifierProvider<AuthenticationNotifier, AuthenticationState>(
  (ref) => AuthenticationNotifier(
    ref.read(authenticationApi),
    ref.read(loginFieldProviderRef),
    ref.read(tokenRepositoryProvider),
  ),
);

class AuthenticationNotifier extends StateNotifier<AuthenticationState> {
  final IAuthApi _api;
  final LoginFieldProvider _loginFieldProvider;
  final TokenRepositoryProvider _tokenRepositoryProvider;
  AuthenticationNotifier(
    this._api,
    this._loginFieldProvider,
    this._tokenRepositoryProvider,
  ) : super(const AuthenticationInitial());

  Future<void> init() async {
      await _tokenRepositoryProvider.getToken();
      state=Authenticated(_tokenRepositoryProvider.user);
  }
  User? get user => state is Authenticated
      ? (state as Authenticated).user
      : null;
  Future<void> login() async {
    state = const AuthenticationLoading();
    try {
      final response = await _api.login(_loginFieldProvider.loginRequest);
      await saveAuthData(response!);
      state = Authenticated(response);
    } catch (e) {
      state = const AuthenticationInitial();
      rethrow;
    }
  }

  Future<void> saveAuthData(User user) async {
    await _tokenRepositoryProvider.setToken(user.uid);
  }


  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await _tokenRepositoryProvider.deleteToken();
    state = const UnAuthenticated();
  }
}
