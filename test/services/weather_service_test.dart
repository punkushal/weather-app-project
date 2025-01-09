import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

void main() {
  late WeatherService weatherService;

  setUp(() {
    weatherService = WeatherService();
  });

  group('WeatherService -', () {
    group('get current weather by location', () {
      test(
          'given WeatherSevice class when getCurrentWeatherByLoction function is called and status code  is 200 then WeatherModel returned',
          () async {
        //Act
        final weather = await weatherService.getWeatherByLocation('Butwal');
        //Assert
        expect(weather, isA<WeatherModel>());
      });

      test(
          'given WeatherSevice class when getCurrentWeatherByCoordinates function is called and status code  is 200 then WeatherModel returned',
          () async {
        //Act
        final weather =
            await weatherService.getWeatherByCoordinates(27.7103, 85.3222);
        //Assert
        expect(weather, isA<WeatherModel>());
      });
    });
  });
}
