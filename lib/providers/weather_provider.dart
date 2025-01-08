import 'package:flutter/material.dart';

import '../models/weather_model.dart';
import '../services/location_service.dart';
import '../services/storage_service.dart';
import '../services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService;
  final LocationService _locationService;
  final StorageService _storageService;

  WeatherModel? _weather;
  String? _error;
  bool _isLoading = false;
  bool _isLocationEnabled = true;

  WeatherProvider({
    required WeatherService weatherService,
    required LocationService locationService,
    required StorageService storageService,
  })  : _weatherService = weatherService,
        _locationService = locationService,
        _storageService = storageService;

  WeatherModel? get weather => _weather;
  String? get error => _error;
  bool get isLoading => _isLoading;
  bool get isLocationEnabled => _isLocationEnabled;

  Future<void> getWeatherByLocation(
      String location, BuildContext context) async {
    if (location.isEmpty) {
      return getWeatherByCurrentLocation(context);
    }

    try {
      _setLoadingState(true);

      _weather = await _weatherService.getWeatherByLocation(location);
      await _storageService.saveLocation(location);
    } catch (e) {
      _setError('Failed to get weather: ${e.toString()}');
    } finally {
      _setLoadingState(false);
    }
  }

  Future<void> getWeatherByCurrentLocation(BuildContext context) async {
    try {
      _setLoadingState(true);

      final position = await _locationService.getCurrentLocation(context);

      if (position == null) {
        _isLocationEnabled = false;
        notifyListeners();

        _setError(
            'Unable to get location. Please enable location services or enter a location manually.');
        return;
      }

      _isLocationEnabled = true;
      _weather = await _weatherService.getWeatherByCoordinates(
        position.latitude,
        position.longitude,
      );
    } catch (e) {
      _setError('Failed to get weather: ${e.toString()}');
    } finally {
      _setLoadingState(false);
    }
  }

  void _setLoadingState(bool loading) {
    _isLoading = loading;
    _error = null;
    notifyListeners();
  }

  void _setError(String errorMessage) {
    _error = errorMessage;
    notifyListeners();
  }

  // Method to retry getting weather with current location
  Future<void> retryWithLocation(BuildContext context) async {
    await getWeatherByCurrentLocation(context);
  }
}
