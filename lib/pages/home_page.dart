import 'package:flutter/material.dart';
import 'package:weather_app/pages/help_page.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/widgets/location_input.dart';
import 'package:provider/provider.dart';

import '../services/storage_service.dart';
import '../widgets/temperature_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _locationController = TextEditingController();

  @override
  void initState() {
    _loadInitialData();
    super.initState();
  }

  Future<void> _loadInitialData() async {
    final weatherProvider = context.read<WeatherProvider>();
    final savedLocation = context.read<StorageService>().getLocation();

    if (savedLocation != null) {
      _locationController.text = savedLocation;
      await weatherProvider.getWeatherByLocation(savedLocation, context);
    } else {
      await weatherProvider.getWeatherByCurrentLocation(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HelpPage()),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 20,
          children: [
            LocationInput(
              controller: _locationController,
              onSubmit: () => _handleLocationSubmit(context),
            ),
            Consumer<WeatherProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (provider.error != null) {
                  return Center(
                    child: Text('Failed to fetch weather data'),
                  );
                } else if (provider.weather != null) {
                  return TemperatureView(weather: provider.weather!);
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleLocationSubmit(BuildContext context) {
    final location = _locationController.text.trim();
    context.read<WeatherProvider>().getWeatherByLocation(location, context);
  }
}
