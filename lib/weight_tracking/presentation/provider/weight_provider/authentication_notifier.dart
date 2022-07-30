import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker/weight_tracking/presentation/provider/weight_provider/weight_state.dart';
import '../../../data/datasource/remote/apis/authentication_api.dart';
import '../../../data/datasource/remote/apis/weight_api.dart';
import '../../../data/datasource/remote/interfaces/i_authentication_api.dart';
import '../../../data/datasource/remote/interfaces/i_weight_api.dart';
import '../../../domain/core/weight.dart';
import '../fields_providers/login_field_provider.dart';
import '../token_repository_provider.dart';

final authenticationNotifierProvider =
    StateNotifierProvider<AuthenticationNotifier, WeightState>(
  (ref) => AuthenticationNotifier(
    ref.read(weightApi),
    ref.read(loginFieldProviderRef),
    ref.read(tokenRepositoryProvider),
  ),
);

class AuthenticationNotifier extends StateNotifier<WeightState> {
  final IWeightApi _api;
  final LoginFieldProvider _loginFieldProvider;
  final TokenRepositoryProvider _tokenRepositoryProvider;

  AuthenticationNotifier(
    this._api,
    this._loginFieldProvider,
    this._tokenRepositoryProvider,
  ) : super(const WeightInitial());

  Future<void> addWeight(Weight weight) async {
    state = const WeightLoading();
    try {
      final response =
          await _api.addWeight(weight, _tokenRepositoryProvider.token);

      state = WeightPost();
    } catch (e) {
      rethrow;
    }
  }
}
