// lib/worker_model.dart

class Worker {
  // Identity Fields (8)
  String name;
  String dob;
  String gender;
  String fatherOrHusbandName;
  String maritalStatus;
  String mobileNumber;
  String emergencyContact;
  String address;


  // Health Fields (14)
  String? id; // Add this line to store the unique Firestore ID

  // ... all the other fields ...
  String? bloodGroup;
  String? height;
  String? weight;
  String? knownAllergies;
  String? currentMedicines;
  String? pastSurgeries;
  String? chronicIllnesses;
  String? recentInjuries;
  String? isSmoker;
  String? drinksAlcohol;
  String? familyMedicalHistory;
  String? vaccinationStatus;
  String? eyesightIssues;
  String? hearingIssues;

  Worker({
    // Required Identity Fields
    required this.name,
    required this.dob,
    required this.gender,
    required this.fatherOrHusbandName,
    required this.maritalStatus,
    required this.mobileNumber,
    required this.emergencyContact,
    required this.address,

    // Optional Health Fields
    this.id, // Add this to the constructor
    // ... all the other required fields ...
    this.bloodGroup,
    this.height,
    this.weight,
    this.knownAllergies,
    this.currentMedicines,
    this.pastSurgeries,
    this.chronicIllnesses,
    this.recentInjuries,
    this.isSmoker,
    this.drinksAlcohol,
    this.familyMedicalHistory,
    this.vaccinationStatus,
    this.eyesightIssues,
    this.hearingIssues,
  });
}