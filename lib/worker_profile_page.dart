// lib/worker_profile_page.dart

import 'package:flutter/material.dart';
import 'worker_model.dart';

class WorkerProfilePage extends StatelessWidget {
  final Worker worker;
  final VoidCallback onConfirm; // Function to call when confirming
  final VoidCallback onEdit;    // Function to call when editing

  const WorkerProfilePage({
    super.key,
    required this.worker,
    required this.onConfirm,
    required this.onEdit,
  });

  // Helper widget to create a consistent row for each detail
  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140, // Adjusted width for longer labels
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(value ?? 'Not provided'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Worker Details'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false, // Removes back button
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Identity Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                const Divider(),
                _buildDetailRow('Full Name', worker.name),
                _buildDetailRow('Date of Birth', worker.dob),
                _buildDetailRow('Gender', worker.gender),
                _buildDetailRow("Father's/Husband's Name", worker.fatherOrHusbandName),
                _buildDetailRow('Marital Status', worker.maritalStatus),
                _buildDetailRow('Phone Number', worker.mobileNumber),
                _buildDetailRow('Emergency Contact', worker.emergencyContact),
                _buildDetailRow('Current Address', worker.address),

                const SizedBox(height: 24),

                const Text(
                  'Health Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                const Divider(),
                _buildDetailRow('Blood Group', worker.bloodGroup),
                _buildDetailRow('Height (cm)', worker.height),
                _buildDetailRow('Weight (kg)', worker.weight),
                _buildDetailRow('Known Allergies', worker.knownAllergies),
                _buildDetailRow('Current Medicines', worker.currentMedicines),
                _buildDetailRow('Past Surgeries', worker.pastSurgeries),
                _buildDetailRow('Long-term Illnesses', worker.chronicIllnesses),
                _buildDetailRow('Recent Injuries', worker.recentInjuries),
                _buildDetailRow('Smokes/Uses Tobacco', worker.isSmoker),
                _buildDetailRow('Drinks Alcohol', worker.drinksAlcohol),
                _buildDetailRow('Family Medical History', worker.familyMedicalHistory),
                _buildDetailRow('Vaccination Details', worker.vaccinationStatus),
                _buildDetailRow('Eyesight Issues', worker.eyesightIssues),
                _buildDetailRow('Hearing Issues', worker.hearingIssues),
              ],
            ),
          ),
        ),
      ),
      // Buttons for Edit and Confirm
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text('Edit Details'),
                onPressed: onEdit,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  foregroundColor: Colors.teal,
                  side: const BorderSide(color: Colors.teal),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check_circle),
                label: const Text('Confirm & Save'),
                onPressed: onConfirm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}