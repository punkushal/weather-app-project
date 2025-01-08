import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/weather_model.dart';
import '../utils/app_constants.dart';

class WeatherService {
  Future<WeatherModel> getWeatherByLocation(String location) async {
    final response = await http.get(
      Uri.parse(
          '${AppConstants.baseUrl}${AppConstants.weatherEndpoint}?key=${AppConstants.apiKey}&q=$location'),
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<WeatherModel> getWeatherByCoordinates(double lat, double lon) async {
    final response = await http.get(
      Uri.parse(
          '${AppConstants.baseUrl}${AppConstants.weatherEndpoint}?key=${AppConstants.apiKey}&q=$lat,$lon'),
    );

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
