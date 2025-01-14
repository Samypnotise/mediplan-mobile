import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:mediplan/models/directions.dart';

class DirectionsRepository {
  static const String _baseUrl =
      "https://maps.googleapis.com/maps/api/directions/json";

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await http.get(
      Uri.parse(
          "$_baseUrl?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=${dotenv.env['GOOGLE_MAPS_API_KEY']}"),
    );

    if (response.statusCode == 200) {
      return Directions.fromMap(jsonDecode(response.body));
    }

    return null;
  }
}
