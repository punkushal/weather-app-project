import 'package:flutter/material.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/help_page.dart';
import 'pages/home_page.dart';
import 'providers/weather_provider.dart';
import 'services/storage_service.dart';
import 'services/weather_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final storageService = StorageService(prefs);
  runApp(MultiProvider(providers: [
    Provider<LocationService>(
      create: (context) => LocationService(),
    ),
    Provider<WeatherService>(
      create: (_) => WeatherService(),
    ),
    Provider<StorageService>(
      create: (_) => storageService,
    ),
    ChangeNotifierProvider(
      create: (context) => WeatherProvider(
        weatherService: context.read<WeatherService>(),
        locationService: context.read<LocationService>(),
        storageService: context.read<StorageService>(),
      ),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: context.read<StorageService>().isFirstLaunch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return snapshot.data == true ? HelpPage() : HomePage();
        },
      ),
    );
  }
}
