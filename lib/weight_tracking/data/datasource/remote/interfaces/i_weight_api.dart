import 'package:firebase_auth/firebase_auth.dart';
import '../../../../domain/core/login_request.dart';
import '../../../../domain/core/register_request.dart';
import '../../../../domain/core/weight.dart';

/// This is the interface that the remote data source must implement.
abstract class IWeightApi {
  /// This method is used to add the user's weight data.
Future <void> addWeight(Weight weight, String token);
  /// This method is used to delete the user's weight data.
Future <void> deleteWeight(String id, String token);
/// This method is used to update the user's weight data.
Future <void> updateWeight(Weight weight, String token);
/// This method is used to get the user's weight data.
Future <List<Weight>> getWeights( String token);



}
