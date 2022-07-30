import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker/weight_tracking/presentation/provider/weight_provider/weight_state.dart';
import '../../../data/datasource/remote/apis/authentication_api.dart';
import '../../../data/datasource/remote/apis/weight_api.dart';
import '../../../data/datasource/remote/interfaces/i_authentication_api.dart';
import '../../../data/datasource/remote/interfaces/i_weight_api.dart';
import '../../../domain/core/weight.dart';
import '../fields_providers/login_field_provider.dart';
import '../fields_providers/weight_field_provider.dart';
import '../token_repository_provider.dart';

final addWeightNotifierProvider =
    StateNotifierProvider<AddWeightnNotifier, WeightState>(
  (ref) => AddWeightnNotifier(
    ref.read(weightApi),
    ref.read(weightFieldProviderRef),
    ref.read(tokenRepositoryProvider),
  ),
);

class AddWeightnNotifier extends StateNotifier<WeightState> {
  final IWeightApi _api;
  final WeightFieldProvider _weightFieldProvider;
  final TokenRepositoryProvider _tokenRepositoryProvider;

  AddWeightnNotifier(
    this._api,
    this._weightFieldProvider,
    this._tokenRepositoryProvider,
  ) : super(const WeightInitial());

  Future<void> addWeight() async {
    state = const WeightLoading();
    try {

      final response =
          await _api.addWeight(_weightFieldProvider.weightClass, _tokenRepositoryProvider.token);

      state = WeightPost();
    } catch (e) {
      rethrow;
    }
  }
}
