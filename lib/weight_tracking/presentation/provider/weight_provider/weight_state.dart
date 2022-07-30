
import '../../../domain/core/weight.dart';

abstract class WeightState {
  const WeightState();
}

class WeightInitial extends WeightState {
  const WeightInitial();
}

class WeightLoading extends WeightState {
  const WeightLoading();
}

class GotWeight extends WeightState {
  final Weight? weight;
  const GotWeight(this.weight);
}class WeightPost extends WeightState {
  const WeightPost();
}

