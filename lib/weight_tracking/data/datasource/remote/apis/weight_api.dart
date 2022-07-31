import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../settings/helpers/ui_helpers.dart';
import '../../../../domain/core/login_request.dart';
import '../../../../domain/core/register_request.dart';
import '../../../../domain/core/weight.dart';
import '../endpoints.dart';
import '../interfaces/i_authentication_api.dart';
import 'package:http/http.dart' as http;

import '../interfaces/i_weight_api.dart';

/// This is the provider that provides the remote data source.
final Provider<IWeightApi> weightApi = Provider<IWeightApi>(
  (ProviderRef<IWeightApi> ref) => WeightApi(),
);

class WeightApi implements IWeightApi {
  WeightApi();

  @override
  Future<void> addWeight(Weight weight, String token) async {
    try {
      final url = Uri.parse(kFirebaseUrl(token));
      log("addWeight : ${weight.toJson()}");
      final response = await http.post(url, body: json.encode(weight.toJson()));
      log("addWeight : ${response.body.toString()}");
    } on SocketException {
      throw const HttpException('No Internet Connection');
    } on Exception {
      throw const HttpException('Something went wrong');
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> deleteWeight(String id, String token) async {
    try {
      final url = Uri.parse(kDeleteWieghtUrl(id,token));
      final response = await http.delete(url);
      log("deleteWeight : ${response.body.toString()}");
    } on SocketException {
      throw const HttpException('No Internet Connection');
    } on Exception {
      throw const HttpException('Something went wrong');
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<Weight>> getWeights(String token) async {
    List<Weight> weights = [];
    try {
      final Uri url = Uri.parse(kFirebaseUrl(token));
      log("getWeights : $url");
      final  response = await http.get(url);
      log("getWeights : ${response.body.toString()}");

      if(response.body.isNotEmpty ) {
        final Map<String, dynamic> extractedData = json.decode(response.body);
        extractedData.forEach((id, weightData) {
          weights.add(Weight(
            id: id,
            weight: weightData['weight'],
            date: weightData['date'],
          ));
        });
        return weights;
      }
      return [];
    } on SocketException {
      throw const HttpException('No Internet Connection');
    } on Exception {
      throw const HttpException('Something went wrong');
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> updateWeight(Weight weight, String token) async {
    final url = Uri.parse(kFirebaseUrl(token));
    try {
      final response =
          await http.patch(url, body: json.encode(weight.toJson()));
    } on SocketException {
      throw const HttpException('No Internet Connection');
    } on Exception {
      throw const HttpException('Something went wrong');
    } catch (e) {
      throw e;
    }
  }
}
