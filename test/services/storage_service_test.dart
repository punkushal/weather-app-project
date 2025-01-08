import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/services/storage_service.dart';
import 'package:weather_app/utils/app_constants.dart';

void main() {
  group('StorageService Tests', () {
    late StorageService storageService;
    late SharedPreferences prefs;

    setUp(() async {
      // Setup mock SharedPreferences
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      storageService = StorageService(prefs);
    });

    group('Location Tests', () {
      test('saveLocation should store location in SharedPreferences', () async {
        // Arrange
        const testLocation = 'London';

        // Act
        await storageService.saveLocation(testLocation);

        // Assert
        expect(prefs.getString(AppConstants.locationKey), testLocation);
      });

      test('getLocation should return null when no location is saved', () {
        // Act
        final result = storageService.getLocation();

        // Assert
        expect(result, null);
      });

      test('getLocation should return saved location', () async {
        // Arrange
        const testLocation = 'Paris';
        await prefs.setString(AppConstants.locationKey, testLocation);

        // Act
        final result = storageService.getLocation();

        // Assert
        expect(result, testLocation);
      });
    });

    group('First Launch Tests', () {
      test('isFirstLaunch should return true by default', () async {
        // Act
        final result = await storageService.isFirstLaunch();

        // Assert
        expect(result, true);
      });

      test('isFirstLaunch should return false after setFirstLaunch(false)',
          () async {
        // Arrange
        await storageService.setFirstLaunch(false);

        // Act
        final result = await storageService.isFirstLaunch();

        // Assert
        expect(result, false);
      });

      test('setFirstLaunch should persist value in SharedPreferences',
          () async {
        // Act
        await storageService.setFirstLaunch(false);

        // Assert
        expect(prefs.getBool(AppConstants.firstLaunchKey), false);
      });
    });
  });
}
