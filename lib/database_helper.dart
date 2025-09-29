// lib/database_helper.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'worker_model.dart';

class DatabaseHelper {
  static final CollectionReference _workersCollection = FirebaseFirestore.instance.collection('workers');

  // Saves a complete worker profile and returns the new document's unique ID
  static Future<String> addWorker(Worker worker) async {
    Map<String, dynamic> workerData = {
      // Demographic Info
      'name': worker.name,
      'dob': worker.dob,
      'gender': worker.gender,
      'fatherOrHusbandName': worker.fatherOrHusbandName,
      'maritalStatus': worker.maritalStatus,
      'mobileNumber': worker.mobileNumber,
      'emergencyContact': worker.emergencyContact,
      'address': worker.address,
      // Health Info
      'bloodGroup': worker.bloodGroup,
      'height': worker.height,
      'weight': worker.weight,
      'knownAllergies': worker.knownAllergies,
      'currentMedicines': worker.currentMedicines,
      'pastSurgeries': worker.pastSurgeries,
      'chronicIllnesses': worker.chronicIllnesses,
      'recentInjuries': worker.recentInjuries,
      'isSmoker': worker.isSmoker,
      'drinksAlcohol': worker.drinksAlcohol,
      'familyMedicalHistory': worker.familyMedicalHistory,
      'vaccinationStatus': worker.vaccinationStatus,
      'eyesightIssues': worker.eyesightIssues,
      'hearingIssues': worker.hearingIssues,
      // Metadata
      'timestamp': FieldValue.serverTimestamp(),
    };
    DocumentReference docRef = await _workersCollection.add(workerData);
    return docRef.id;
  }

  // Loads all worker profiles from Firestore
  static Future<List<Worker>> loadWorkers() async {
    QuerySnapshot snapshot = await _workersCollection.orderBy('timestamp', descending: true).get();
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Worker(
        id: doc.id, // Also load the document ID
        name: data['name'] ?? '',
        dob: data['dob'] ?? '',
        gender: data['gender'] ?? '',
        fatherOrHusbandName: data['fatherOrHusbandName'] ?? '',
        maritalStatus: data['maritalStatus'] ?? '',
        mobileNumber: data['mobileNumber'] ?? '',
        emergencyContact: data['emergencyContact'] ?? '',
        address: data['address'] ?? '',
        bloodGroup: data['bloodGroup'] ?? '',
        height: data['height'] ?? '',
        weight: data['weight'] ?? '',
        knownAllergies: data['knownAllergies'] ?? '',
        currentMedicines: data['currentMedicines'] ?? '',
        pastSurgeries: data['pastSurgeries'] ?? '',
        chronicIllnesses: data['chronicIllnesses'] ?? '',
        recentInjuries: data['recentInjuries'] ?? '',
        isSmoker: data['isSmoker'] ?? '',
        drinksAlcohol: data['drinksAlcohol'] ?? '',
        familyMedicalHistory: data['familyMedicalHistory'] ?? '',
        vaccinationStatus: data['vaccinationStatus'] ?? '',
        eyesightIssues: data['eyesightIssues'] ?? '',
        hearingIssues: data['hearingIssues'] ?? '',
      );
    }).toList();
  }
}