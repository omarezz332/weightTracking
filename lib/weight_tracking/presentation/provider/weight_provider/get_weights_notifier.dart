import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker/weight_tracking/presentation/provider/weight_provider/weight_state.dart';
import '../../../data/datasource/remote/apis/authentication_api.dart';
import '../../../data/datasource/remote/apis/weight_api.dart';
import '../../../data/datasource/remote/interfaces/i_authentication_api.dart';
import '../../../data/datasource/remote/interfaces/i_weight_api.dart';
import '../../../domain/core/weight.dart';
import '../fields_providers/register_field_provider.dart';
import '../token_repository_provider.dart';

final StateNotifierProvider<GetweightNotifier, WeightState> getWeightNotifierProviderRef =
    StateNotifierProvider<GetweightNotifier, WeightState>((
  ref,
) {
  return GetweightNotifier(
    ref.read(weightApi),
    ref.read(tokenRepositoryProvider),
  );
});

class GetweightNotifier extends StateNotifier<WeightState> {
  final IWeightApi _api;
  final TokenRepositoryProvider _tokenRepositoryProvider;
  GetweightNotifier(this._api, this._tokenRepositoryProvider) : super(const WeightInitial());

  Future<void> getWeight() async {
    try{
      state = const WeightLoading();
      final response=   await _api.getWeights(_tokenRepositoryProvider.token);
      state =  GotWeight( weights: response);
    }on Exception{
      state = const WeightError();
    }

  }
}
