// lib/demographics_form.dart

import 'package:flutter/material.dart';
import 'health_profile_form.dart';
import 'worker_model.dart';
import 'aadhaar_parser.dart';

class DemographicsForm extends StatefulWidget {
  final AadhaarData? aadhaarData;
  const DemographicsForm({super.key, this.aadhaarData});

  @override
  State<DemographicsForm> createState() => _DemographicsFormState();
}

class _DemographicsFormState extends State<DemographicsForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for all 8 fields
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();
  final _fatherOrHusbandNameController = TextEditingController();
  final _maritalStatusController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.aadhaarData != null) {
      _nameController.text = widget.aadhaarData!.name;
      _dobController.text = widget.aadhaarData!.dob;
      _genderController.text = widget.aadhaarData!.gender;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    _fatherOrHusbandNameController.dispose();
    _maritalStatusController.dispose();
    _mobileController.dispose();
    _emergencyContactController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // A quick check to ensure all fields are filled, though validation is better
    if (_formKey.currentState?.validate() ?? false) {
      final newWorker = Worker(
        name: _nameController.text,
        dob: _dobController.text,
        gender: _genderController.text,
        fatherOrHusbandName: _fatherOrHusbandNameController.text,
        maritalStatus: _maritalStatusController.text,
        mobileNumber: _mobileController.text,
        emergencyContact: _emergencyContactController.text,
        address: _addressController.text,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HealthProfileForm(worker: newWorker),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Worker Registration (Step 1 of 2)'),
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
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                controller: _dobController,
                decoration: const InputDecoration(labelText: 'Date of Birth'),
                validator: (value) => value!.isEmpty ? 'Please enter a date of birth' : null,
              ),
              TextFormField(
                controller: _genderController,
                decoration: const InputDecoration(labelText: 'Gender (Male/Female/Other)'),
                validator: (value) => value!.isEmpty ? 'Please enter a gender' : null,
              ),
              TextFormField(
                controller: _fatherOrHusbandNameController,
                decoration: const InputDecoration(labelText: "Father's or Husband's Name"),
                validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                controller: _maritalStatusController,
                decoration: const InputDecoration(labelText: 'Are you Married? (Yes/No)'),
                validator: (value) => value!.isEmpty ? 'Please enter marital status' : null,
              ),
              TextFormField(
                controller: _mobileController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Please enter a phone number' : null,
              ),
              TextFormField(
                controller: _emergencyContactController,
                decoration: const InputDecoration(labelText: 'Emergency Contact Number'),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Please enter an emergency number' : null,
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Current Address'),
                validator: (value) => value!.isEmpty ? 'Please enter an address' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Next: Health Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}