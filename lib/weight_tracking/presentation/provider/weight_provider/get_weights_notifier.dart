import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker/weight_tracking/presentation/provider/weight_provider/weight_state.dart';
import '../../../data/datasource/remote/apis/authentication_api.dart';
import '../../../data/datasource/remote/apis/weight_api.dart';
import '../../../data/datasource/remote/interfaces/i_authentication_api.dart';
import '../../../data/datasource/remote/interfaces/i_weight_api.dart';
import '../../../domain/core/weight.dart';
import '../fields_providers/register_field_provider.dart';

final StateNotifierProvider<GetweightNotifier, WeightState> getWeightNotifierProviderRef =
    StateNotifierProvider<GetweightNotifier, WeightState>((
  ref,
) {
  return GetweightNotifier(
    ref.read(weightApi),
    ref.read(registerFieldProviderRef),
  );
});

class GetweightNotifier extends StateNotifier<WeightState> {
  final IWeightApi _api;
  final RegisterFieldProvider _registerFieldProvider;

  GetweightNotifier(this._api, this._registerFieldProvider) : super(const WeightInitial());

  Future<List<Weight>> getWeight(String token) async {
    return await _api.getWeights(token);
  }
}
