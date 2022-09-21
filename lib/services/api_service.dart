import 'package:pumping_iron/models/exercise.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/exercise.dart';

class ApiService {
  // API key
  static const _apiKey = "307f112960msh09256229e3e1b0dp14a7e3jsn8cd92a7445f6";

  // Base API url
  static const String _baseUrl = "exercisedb.p.rapidapi.com";

  // Base headers for Response url
  static const Map<String, String> _headers = {
    "content-type": "application/json",
    "x-rapidapi-host": _baseUrl,
    "x-rapidapi-key": _apiKey,
  };

  // Base API request to get response
  // Future<List<Exercise>> get({
  Future<List<Exercise>> get({
    required String endpoint,
    // required Map<String, String> query,
  }) async {
    Uri uri = Uri.https(_baseUrl, endpoint);
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      List body = json.decode(response.body);

      var prices = List<Exercise>.generate(
          body.length, (index) => Exercise.fromJson(body[index])
      );

      // If server returns an OK response, parse the JSON.
      return prices;
    }
    else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load json data');
    }
  }

  Future<List<Exercise>> get2({
    required String endpoint,
    // required Map<String, String> query,
  }) async {
    Uri uri = Uri.https(_baseUrl, endpoint);
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      List body = json.decode(response.body);

      var prices = List<Exercise>.generate(
          body.length, (index) => Exercise.fromJson(body[index])
      );

      // If server returns an OK response, parse the JSON.
      return prices;
    }
    else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load json data');
    }
  }

  // Future<List<String>> getTargets({
  //   required String endpoint,
  //   // required Map<String, String> query,
  // }) async {
  //   Uri uri = Uri.https(_baseUrl, endpoint);
  //   final response = await http.get(uri, headers: _headers);
  //   if (response.statusCode == 200) {
  //     List body = json.decode(response.body);
  //
  //     var targets = List<String>.generate(
  //         body.length, (index) => body[index]);
  //
  //     // If server returns an OK response, parse the JSON.
  //     return targets;
  //   }
  //   else {
  //     // If that response was not OK, throw an error.
  //     throw Exception('Failed to load json data');
  //   }
  // }

}