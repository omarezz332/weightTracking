
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
  final List<Weight> weights;
   GotWeight({this.weights = const []});
}
class WeightPost extends WeightState {
  const WeightPost();
}

class WeightError extends WeightState {
  const WeightError();
}