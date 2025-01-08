import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class LocationService {
  Future<Position?> getCurrentLocation(BuildContext context) async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Show snackbar with option to open location settings
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                  'Location services are disabled. Please enable to get weather updates.'),
              duration: const Duration(seconds: 5),
              action: SnackBarAction(
                label: 'Enable',
                onPressed: () async {
                  // Open location settings
                  await Geolocator.openLocationSettings();
                },
              ),
            ),
          );
        }
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Location permissions are denied. Weather information may not be accurate.'),
                duration: Duration(seconds: 3),
              ),
            );
          }
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                  'Location permissions are permanently denied. Please enable in settings.'),
              duration: const Duration(seconds: 5),
              action: SnackBarAction(
                label: 'Settings',
                onPressed: () async {
                  await Geolocator.openAppSettings();
                },
              ),
            ),
          );
        }
        return null;
      }

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error getting location: ${e.toString()}'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
      return null;
    }
  }
}
