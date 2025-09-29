// lib/registration_success_page.dart

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'worker_model.dart';

class RegistrationSuccessPage extends StatelessWidget {
  final Worker worker;

  const RegistrationSuccessPage({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Successful'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 80),
              const SizedBox(height: 20),
              Text(
                '${worker.name} is now registered!',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Worker ID: ${worker.id}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              const Text(
                'Unique QR Code:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              // This widget generates the QR code
              QrImageView(
                data: worker.id!, // The data is the worker's unique ID
                version: QrVersions.auto,
                size: 200.0,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to the very first screen (HomeScreen)
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Register Another Worker'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}