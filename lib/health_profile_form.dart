// lib/health_profile_form.dart

import 'package:flutter/material.dart';
import 'worker_model.dart';
import 'database_helper.dart';
import 'registration_success_page.dart';
import 'worker_profile_page.dart';

class HealthProfileForm extends StatefulWidget {
  final Worker worker;
  const HealthProfileForm({super.key, required this.worker});

  @override
  State<HealthProfileForm> createState() => _HealthProfileFormState();
}

class _HealthProfileFormState extends State<HealthProfileForm> {
  final _formKey = GlobalKey<FormState>();

  // ... (all 14 TextEditingControllers are the same as before) ...
  final _bloodGroupController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _medicationsController = TextEditingController();
  final _surgeriesController = TextEditingController();
  final _illnessesController = TextEditingController();
  final _injuriesController = TextEditingController();
  final _smokerController = TextEditingController();
  final _alcoholController = TextEditingController();
  final _familyHistoryController = TextEditingController();
  final _vaccinationController = TextEditingController();
  final _eyesightController = TextEditingController();
  final _hearingController = TextEditingController();

  @override
  void dispose() {
    // ... (dispose all controllers as before) ...
    super.dispose();
  }

  void _submitHealthForm() {
    if (_formKey.currentState!.validate()) {
      // 1. Update the worker object with the health data
      widget.worker.bloodGroup = _bloodGroupController.text;
      widget.worker.height = _heightController.text;
      widget.worker.weight = _weightController.text;
      widget.worker.knownAllergies = _allergiesController.text;
      widget.worker.currentMedicines = _medicationsController.text;
      widget.worker.pastSurgeries = _surgeriesController.text;
      widget.worker.chronicIllnesses = _illnessesController.text;
      widget.worker.recentInjuries = _injuriesController.text;
      widget.worker.isSmoker = _smokerController.text;
      widget.worker.drinksAlcohol = _alcoholController.text;
      widget.worker.familyMedicalHistory = _familyHistoryController.text;
      widget.worker.vaccinationStatus = _vaccinationController.text;
      widget.worker.eyesightIssues = _eyesightController.text;
      widget.worker.hearingIssues = _hearingController.text;

      // 2. Navigate to the REVIEW page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkerProfilePage(
            worker: widget.worker,
            onEdit: () {
              // If "Edit" is tapped on the review page, it just comes back here
              Navigator.pop(context);
            },
            onConfirm: () {
              // If "Confirm" is tapped, we save to the database and go to the success page
              DatabaseHelper.addWorker(widget.worker).then((String workerId) {
                widget.worker.id = workerId;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistrationSuccessPage(worker: widget.worker),
                  ),
                      (route) => route.isFirst,
                );
              }).catchError((error, stackTrace) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to register worker: $error'),
                    backgroundColor: Colors.red,
                  ),
                );
              });
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // The build method with all the TextFormFields is exactly the same as before
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Profile (Step 2 of 2)'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // ... (all 14 TextFormField widgets are here, same as before) ...
              TextFormField(controller: _bloodGroupController, decoration: const InputDecoration(labelText: 'Blood Group'), validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: _heightController, decoration: const InputDecoration(labelText: 'Height (in cm)'), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: _weightController, decoration: const InputDecoration(labelText: 'Weight (in kg)'), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: _allergiesController, decoration: const InputDecoration(labelText: 'Known Allergies? (from medicine, food, dust)'), validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: _medicationsController, decoration: const InputDecoration(labelText: 'Current Medicines? (Are you taking any right now?)'), validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: _surgeriesController, decoration: const InputDecoration(labelText: 'Past Surgeries? (Have you had any operations?)'), validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: _illnessesController, decoration: const InputDecoration(labelText: 'Long-term Illnesses? (Diabetes, BP, Asthma)'), validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: _injuriesController, decoration: const InputDecoration(labelText: 'Recent Injuries? (Any recent accidents or deep cuts?)'), validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: _smokerController, decoration: const InputDecoration(labelText: 'Do you smoke or use tobacco? (Yes/No)'), validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: _alcoholController, decoration: const InputDecoration(labelText: 'Do you drink alcohol? (Yes/No)'), validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: _familyHistoryController, decoration: const InputDecoration(labelText: 'Family Medical History? (Major illness in family?)'), validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: _vaccinationController, decoration: const InputDecoration(labelText: 'Vaccination Details? (COVID, Tetanus)'), validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: _eyesightController, decoration: const InputDecoration(labelText: 'Any issues with eyesight? (Yes/No)'), validator: (v) => v!.isEmpty ? 'Required' : null),
              TextFormField(controller: _hearingController, decoration: const InputDecoration(labelText: 'Any issues with hearing? (Yes/No)'), validator: (v) => v!.isEmpty ? 'Required' : null),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitHealthForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Review Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}