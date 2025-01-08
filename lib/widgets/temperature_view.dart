import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

class TemperatureView extends StatelessWidget {
  const TemperatureView({super.key, required this.weather});
  final WeatherModel weather;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 10,
          children: [
            Text(
              weather.location,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Image.network(
                  weather.iconUrl,
                  width: 64,
                  height: 64,
                ),
                Text(
                  '${weather.tempC.toStringAsFixed(1)}°C',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
