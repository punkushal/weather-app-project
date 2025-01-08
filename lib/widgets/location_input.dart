import 'package:flutter/material.dart';

class LocationInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;

  const LocationInput({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter location',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: onSubmit,
          child: Text(controller.text.isEmpty ? 'Save' : 'Update'),
        ),
      ],
    );
  }
}
