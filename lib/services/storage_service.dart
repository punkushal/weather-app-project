import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_constants.dart';

class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  Future<void> saveLocation(String location) async {
    await _prefs.setString(AppConstants.locationKey, location);
  }

  String? getLocation() {
    return _prefs.getString(AppConstants.locationKey);
  }

  Future<bool> isFirstLaunch() async {
    return _prefs.getBool(AppConstants.firstLaunchKey) ?? true;
  }

  Future<void> setFirstLaunch(bool value) async {
    await _prefs.setBool(AppConstants.firstLaunchKey, value);
  }
}
